import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:tes/services/internet/internet_service.dart';

import '../../models/filter/filter_section.dart';
import '../../services/filter/filter_service.dart';

class FilterViewModel extends ChangeNotifier {
  final FilterService _filterService;
  List<FilterSection> _sections = [];
  bool _isLoading = false;
  String? _error;

  final Map<String, List<String>> _selectedFilters = {
    'cuisine': [],
    'suitable-diet': [],
    'experience': [],
    'mealperiod': [],
    'attire': [],
    'location': [],
    'pricerange': [],
    "sort": [],
  };

  List<FilterSection> get sections => _sections;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, List<String>> get selectedFilters => _selectedFilters;

  int get totalResults {
    int count = 0;
    _selectedFilters.forEach((key, value) => count += value.length);
    return count;
  }

  FilterViewModel({FilterService? filterService})
      : _filterService = filterService ?? FilterService() {
    fetchFilters();
  }

  Future<void> fetchFilters() async {
    if ((await isInternetAvailable()) == false) {
      _isLoading = false;
      _error = "no_internet";
      notifyListeners();
      return;
    } else {
      try {
        _isLoading = true;
        _error = null;
        notifyListeners();

        _sections = await _filterService.getFilters();
        notifyListeners();
      } catch (e) {
        print("fetch fileters exception : $e");
        if (e is SocketException) {
          _error = 'no_internet';
        } else {
          _error = 'An unexpected error occurred. Please try again.';
        }
        notifyListeners();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // called when we click on the radio tile
  void toggleOption(String sectionTitle, String optionId) {
    final sectionIndex = _sections.indexWhere((s) => s.title == sectionTitle);
    if (sectionIndex == -1) return;

    final section = _sections[sectionIndex];
    final optionIndex = section.options.indexWhere((o) => o.id == optionId);
    if (optionIndex == -1) return;

    _sections[sectionIndex].options[optionIndex].isSelected =
        !_sections[sectionIndex].options[optionIndex].isSelected;

    final sectionSlug = section.slug;
    if (_sections[sectionIndex].options[optionIndex].isSelected) {
      _selectedFilters[sectionSlug]?.add(optionId);
    } else {
      _selectedFilters[sectionSlug]?.remove(optionId);
    }

    notifyListeners();
  }

  // called when we click on the section
  void toggleSection(String sectionTitle) {
    final index = _sections.indexWhere((s) => s.title == sectionTitle);
    if (index == -1) return;

    _sections[index] = FilterSection(
      title: _sections[index].title,
      slug: _sections[index].slug,
      options: _sections[index].options,
      isExpanded: !_sections[index].isExpanded,
      selectedCount: _sections[index].selectedCount,
    );

    notifyListeners();
  }
}

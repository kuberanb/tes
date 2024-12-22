import 'package:dio/dio.dart';

import '../../models/filter/filter_option.dart';
import '../../models/filter/filter_section.dart';

class FilterService {
  static const String baseUrl = 'https://atom1.blueferns.com/test';
  final Dio _dio;

  FilterService({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<FilterSection>> getFilters() async {
    try {
      final response = await _dio.get('$baseUrl/filter.json');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return _parseFilterSections(data);
      } else {
        throw Exception('Failed to load filters');
      }
    } catch (e) {
      throw Exception('Error fetching filters: $e');
    }
  }

  List<FilterSection> _parseFilterSections(List<dynamic> data) {
    return data.map((section) {
      List<FilterOption> options = [];
      final String sectionSlug = section['slug'];

      if (sectionSlug == 'location') {
        final locations = section['taxonomies'][0]['locations'] as List;
        options = locations
            .map((location) => FilterOption(
                  id: location['slug'],
                  title: location['name'],
                ))
            .toList();
      } else {
        options = (section['taxonomies'] as List?)
                ?.map((taxonomy) => FilterOption(
                      id: taxonomy['slug'],
                      title: taxonomy['name'],
                    ))
                .toList() ??
            [];
      }

      return FilterSection(
        title: section['name'],
        slug: sectionSlug,
        options: options,
      );
    }).toList();
  }
}

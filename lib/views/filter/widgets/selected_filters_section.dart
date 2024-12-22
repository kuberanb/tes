import 'package:flutter/material.dart';
import 'package:tes/models/filter/filter_option.dart';
import 'package:tes/view_models/filter/filter_view_model.dart';

class SelectedFiltersSection extends StatelessWidget {
  final FilterViewModel viewModel;

  const SelectedFiltersSection({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedOptions = <FilterOption>[];

    // Gather all selected options
    for (var section in viewModel.sections) {
      selectedOptions.addAll(
        section.options.where((option) => option.isSelected),
      );
    }

    if (selectedOptions.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: selectedOptions.map(
          (option) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Find the section this option belongs to
                      final section = viewModel.sections.firstWhere(
                        (section) => section.options.contains(option),
                      );
                      viewModel.toggleOption(section.title, option.id);
                    },
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    option.title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

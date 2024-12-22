import 'package:flutter/material.dart';
import 'package:tes/models/filter/filter_section.dart';
import 'package:tes/view_models/filter/filter_view_model.dart';
import 'package:tes/views/filter/widgets/filter_option_tile.dart';

class FilterSectionWidget extends StatelessWidget {
  final FilterSection section;
  final FilterViewModel viewModel;

  const FilterSectionWidget({
    Key? key,
    required this.section,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCount =
        section.options.where((option) => option.isSelected).length;
    final showCount = selectedCount > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                showCount ? '${section.title} ($selectedCount)' : section.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              trailing: Icon(
                section.isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey[600],
              ),
              onTap: () => viewModel.toggleSection(section.title),
            ),
            if (section.isExpanded)
              ...section.options.map(
                (option) => FilterOptionTile(
                    option: option,
                    sectionTitle: section.title,
                    viewModel: viewModel),
              ),
          ],
        ),
      ),
    );
  }
}

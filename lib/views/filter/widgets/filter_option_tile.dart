import 'package:flutter/material.dart';
import 'package:tes/constants/color_palette.dart';
import 'package:tes/models/filter/filter_option.dart';
import 'package:tes/view_models/filter/filter_view_model.dart';

class FilterOptionTile extends StatelessWidget {
  final FilterOption option;
  final String sectionTitle;
  final FilterViewModel viewModel;

  const FilterOptionTile({
    Key? key,
    required this.option,
    required this.sectionTitle,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        option.title,
        style: TextStyle(
          fontSize: 17,
          color: option.isSelected ? Colors.grey[800] : Colors.black87,
          fontWeight: option.isSelected ? FontWeight.w600 : FontWeight.w400,
          letterSpacing: -0.3,
          height: 1.2,
        ),
      ),
      leading: GestureDetector(
        onTap: () => viewModel.toggleOption(sectionTitle, option.id),
        child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.grey[400],
            ),
            child: option.isSelected
                ? const Icon(
                    Icons.radio_button_checked_rounded,
                    color: ColorPalette.purple,
                  )
                : const Icon(Icons.circle_outlined)),
      ),
      onTap: () => viewModel.toggleOption(sectionTitle, option.id),
    );
  }
}

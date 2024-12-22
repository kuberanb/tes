import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes/common_widgets/no_internet_screen.dart';
import 'package:tes/constants/color_palette.dart';
import 'package:tes/constants/size_constants.dart';
import 'package:tes/views/common_widgets/loading_shimmer.dart';
import 'package:tes/views/common_widgets/error_view.dart';
import 'package:tes/views/filter/widgets/filter_appbar.dart';
import 'package:tes/views/filter/widgets/filter_section_widget.dart';
import 'package:tes/views/filter/widgets/results_button.dart';
import 'package:tes/views/filter/widgets/selected_filters_section.dart';

import '../../view_models/filter/filter_view_model.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) {},
      child: Scaffold(
        backgroundColor: ColorPalette.backgroundColor,
        appBar: FilterAppBar(
          title: "Filter Options",
          onBackButtonPressed: () {},
        ),
        body: Consumer<FilterViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const LoadingShimmer();
            }

            if (viewModel.error != null) {
              if (viewModel.error == "no_internet") {
                return NoInternetScreen(onRetry: viewModel.fetchFilters);
              } else {
                return ErrorView(
                  error: viewModel.error!,
                  onRetry: viewModel.fetchFilters,
                );
              }
            }

            return ListView(
              padding: const EdgeInsets.only(right: 10, left: 10),
              children: [
                SelectedFiltersSection(viewModel: viewModel),
                const SizedBox(height: Sizes.spacingLarge),
                ...viewModel.sections.map(
                  (section) => FilterSectionWidget(
                      section: section, viewModel: viewModel),
                ),
              ],
            );
          },
        ),
        floatingActionButton: const ResultsButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

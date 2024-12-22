import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes/view_models/filter/filter_view_model.dart';

class ResultsButton extends StatelessWidget {
  const ResultsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.totalResults == 0) return const SizedBox.shrink();
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: FloatingActionButton.extended(
            onPressed: () async {
              // Implement results navigation
            },
            backgroundColor: const Color(0xFF4B4B4B),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27),
            ),
            label: Text(
              'SHOW ${viewModel.totalResults} RESULTS',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}

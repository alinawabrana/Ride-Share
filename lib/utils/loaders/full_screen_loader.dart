import 'package:flutter/material.dart';

import '../../common/widgets/loaders/animation_loader.dart';
import '../constants/colors.dart';
import '../helpers/helper_function.dart';

class TFullScreenLoader {
  /// Open a full-screen loading dialog with given text and animation.
  ///
  /// Requires: BuildContext to show the dialog
  static void openLoadingDialog(
    BuildContext context,
    String text,
    String animation,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => PopScope(
            canPop: false,
            child: Container(
              color:
                  AHelperFunctions.isDarkMode(context)
                      ? AColors.dark
                      : AColors.white,
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 250),
                    TAnimationLoaderWidget(text: text, animation: animation),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  /// Close the currently open loader dialog.
  static void stopLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

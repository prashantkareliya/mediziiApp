import 'package:flutter/material.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // or your package
import 'custom_loader.dart';

class LoadingWrapper extends StatelessWidget {
  final bool showSpinner;
  final Widget child;

  const LoadingWrapper({
    super.key,
    required this.showSpinner,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: AppColors.transparent,
      blur: 2.0,
      inAsyncCall: showSpinner,
      progressIndicator: CustomLoader(),
      child: child,
    );
  }
}

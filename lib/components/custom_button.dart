import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';

class CustomButton extends StatelessWidget {
  String? text;
  VoidCallback? onPressed;
  double? width;
  double? height;
  Color? textColor;
  double? fontSize;
  FontWeight? fontWeight;
  bool? isLoading;

  CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.width,
    this.height,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? context.width(),
        height: height ?? 45.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0066E3), Color(0xFF00479E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child:
                (isLoading ?? false)
                    ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.5, valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor)),
                    )
                    : Text(
                      text ?? "",
                      style: TextStyle(
                        color: textColor ?? AppColors.whiteColor,
                        fontSize: fontSize ?? 16.r,
                        fontWeight: fontWeight ?? FontWeight.w500,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final int maxLine;
  final int? maxLength;
  final TextInputType? textInputType;
  final Function()? onTap;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLine = 1,
    this.maxLength,
    this.textInputType = TextInputType.text,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != "")
          Text(
          label,
          style: GoogleFonts.dmSans(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary)),
        ),
        SizedBox(height: 5.sp),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          cursorColor: AppColors.primaryColor,
          maxLines: maxLine,
          maxLength: maxLength,
          keyboardType: textInputType,
          onTap: onTap,
          readOnly: readOnly,
          style: GoogleFonts.dmSans(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary)),
          onTapOutside: (d) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          decoration: InputDecoration(
            counter: SizedBox.shrink(),
            hintText: hintText ?? "",
            hintStyle: GoogleFonts.dmSans(
              textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary.withValues(alpha: 0.2)),
            ),
            filled: true,
            fillColor: const Color(0xFFFCFCFC),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.2), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            errorStyle: GoogleFonts.dmSans(
              textStyle: TextStyle(fontSize: 12.sp, color: AppColors.errorRed),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.red, width: 1),
            ),
          ),
        ),
        SizedBox(height: 14.sp),
      ],
    );
  }
}

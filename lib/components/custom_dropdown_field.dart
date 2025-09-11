import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String? label;

  final String? value;
  final String hintText;
  final List<String> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownFormField({
    super.key,
    this.label,
    required this.value,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(label != "")
            Text(
              label ?? "",
              style: GoogleFonts.dmSans(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary)),
            ),
          if(label != "")5.verticalSpace,
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.3)),
              ),
              errorStyle: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 12.sp, color: AppColors.errorRed)),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),

            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Colors.black, // Replace with AppColors.textSecondary if available
              ),
            ),
            hint: Text(
              hintText,
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary.withValues(alpha: 0.2)),
              ),
            ),
            items:
            items.map((String role) {
              return DropdownMenuItem<String>(value: role, child: Text(role, overflow: TextOverflow.ellipsis, maxLines: 1));
            }).toList(),
            onChanged: onChanged,
            validator: validator,
          ),
          if(label != "")14.verticalSpace
        ],
      ),
    );
  }
}

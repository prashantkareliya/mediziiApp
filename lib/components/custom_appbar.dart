import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? rightWidget;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.rightWidget,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          3.horizontalSpace,
          GestureDetector(
            onTap: onBackPressed ?? () => Navigator.of(context).pop(),
            child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.blackColor,
                size: 20.sp
            ),
          ),
          15.horizontalSpace,
          Text(
            title,
            style: GoogleFonts.dmSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ],
      ),
      centerTitle: false,
      actions: rightWidget != null ? [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: rightWidget!,
        ),
      ] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
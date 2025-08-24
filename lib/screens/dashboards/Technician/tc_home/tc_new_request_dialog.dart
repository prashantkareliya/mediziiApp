import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/main.dart';
import 'package:medizii/screens/dashboards/Technician/tc_home/tc_request_accept_pg.dart';

class TechnicianNewRequestDialog extends StatelessWidget {
  const TechnicianNewRequestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.transparent,
      insetPadding: EdgeInsets.all(16),
      child: Container(
        constraints: BoxConstraints(maxWidth: context.width() * 0.9, maxHeight: context.height() * 0.9),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: Offset(0, 10))],
        ),
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("#2123", style: GoogleFonts.dmSans(fontSize: 22.sp, color: AppColors.redColor, fontWeight: FontWeight.w600)),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColors.redColor.withValues(alpha: 0.1)),
                    padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
                    child: Text(
                      LabelString.labelNewRequest,
                      style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.redColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LabelString.labelPickupLocation, style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
                  Text(LabelString.labelDistance, style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "96966 Amalia Green, NY",
                      style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Text("12km", style: GoogleFonts.dmSans(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColors.redColor)),
                ],
              ),
              12.verticalSpace,
              Text(LabelString.labelDropLocation, style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
              Text("ABC Hospital", style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
              12.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        navigationService.pop();
                        navigationService.push(TechnicianRequestAcceptPage());
                      },
                      text: LabelString.labelAccept,
                    ),
                  ),
                  15.horizontalSpace,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        navigationService.pop();
                      },
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: AppColors.gray, width: 1.5),
                        ),
                        child: Center(
                          child: Text(
                            LabelString.labelReject,
                            style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.redColor, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

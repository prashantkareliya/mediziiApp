import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';

class PtMedicalReportDialog extends StatelessWidget {
  const PtMedicalReportDialog({Key? key}) : super(key: key);

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.drlogy.com/assets/uploads/lab/image/x-ray%20chest%20report%20format%20-%20drlogy.webp',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 500,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.medical_services, size: 64, color: Colors.blue),
                            SizedBox(height: 16),
                            Text('Medical Report', style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.gray)),
                            SizedBox(height: 8),
                            Text('X-RAY CHEST', style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Close button positioned at bottom center
            Padding(
              padding: EdgeInsets.only(bottom: 16.sp),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40.sp,
                  height: 40.sp,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: Icon(Icons.close, color: AppColors.red, size: 28.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

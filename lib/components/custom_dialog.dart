import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' show Platform;

import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';

class PlatformAwareDialog {
  static Future<void> show({
    required BuildContext context,
    String title = '',
    String content = '',
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text(title,
          style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp)),
          content: Text(content,
              style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp)),
          actions: [
            CupertinoDialogAction(
              child: Text(cancelText),
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onCancel != null) onCancel();
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onConfirm != null) onConfirm();
              },
              child: Text(confirmText),
            ),
          ],
        ),
      );
    } else {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title, style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp)),
          content: Text(content, style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp)),
          actions: [
            TextButton(
              child: Text(cancelText, style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onCancel != null) onCancel();
              },
            ),
            ElevatedButton(
              child: Text(confirmText, style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onConfirm != null) onConfirm();
              },
            ),
          ],
        ),
      );
    }
  }
}

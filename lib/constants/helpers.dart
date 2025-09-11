import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_colours/app_colors.dart';


class Helpers {
  static PageRoute pageRouteBuilder(widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  static void showSnackBar(BuildContext context, String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: isError ? Colors.red : AppColors.black,
          content: Text(
            msg,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.errorRed.withOpacity(0.9),
        textColor: AppColors.whiteColor,
        fontSize: 16.0);
  }

  static void startCall(String? phone) async {
    final url = Uri.parse('https://wa.me/91$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch WhatsApp';
    }
  }
}
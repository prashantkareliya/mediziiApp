import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/main.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageViewer extends StatelessWidget {
  final String imagePath;

  const FullScreenImageViewer({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              navigationService.pop();
            },
            icon: Icon(Icons.close, color: AppColors.whiteColor),
          ),
        ],
      ),
      body: Center(child: PhotoView(imageProvider: FileImage(File(imagePath)))),
    );
  }
}

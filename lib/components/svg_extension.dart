import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/strings.dart';


class SvgExtension extends StatelessWidget {
  String? itemName;
  Color? iconColor;
  double? height, width;
  SvgExtension({Key? key, required this.itemName, this.iconColor, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(itemName!, height: height, width: width, color: iconColor,
        placeholderBuilder: (BuildContext context) {
          return SvgPicture.asset(ImageString.icPlaceHolder, height: 40.h);
        });
  }
}
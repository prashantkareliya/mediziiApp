import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';

class PtConfirmLocationPage extends StatefulWidget {
  const PtConfirmLocationPage({super.key});

  @override
  State<PtConfirmLocationPage> createState() => _PtConfirmLocationPageState();
}

class _PtConfirmLocationPageState extends State<PtConfirmLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(18.sp, 30.sp, 18.sp, 18.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back_ios, color: AppColors.blackColor, size: 20.sp),
            ),
            Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
              child: Assets.icIcons.notification.svg(),
            ),
          ],
        ),
      ),
      bottomSheet: SelectAddressBottomSheet(),
    );
  }
}

class SelectAddressBottomSheet extends StatelessWidget {
  SelectAddressBottomSheet({super.key});

  TextEditingController pickLocationController = TextEditingController();
  TextEditingController dropLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height() * 0.45,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Center(
            child: Text(
              LabelString.labelSelectAddress,
              style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 18.sp, fontWeight: GoogleFontWeight.semiBold),
            ),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Assets.icIcons.location1.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn)),
                  DottedLine(
                    direction: Axis.vertical,
                    lineLength: 0.073.sh,
                    lineThickness: 1.5,
                    dashLength: 6.0,
                    dashColor: Colors.black,
                    dashGapLength: 1.5,
                  ),
                  Assets.icIcons.location.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                ],
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  children: [
                    CustomTextField(
                      maxLine: 1,
                      label: LabelString.labelPickupLocation,
                      controller: pickLocationController,
                      hintText: LabelString.labelEnterPickupLocation,
                      suffixIcon: Padding(padding: EdgeInsets.all(8.sp), child: Assets.icIcons.location.svg()),
                    ),
                    10.horizontalSpace,
                    Column(
                      children: [
                        CustomTextField(
                          maxLine: 1,
                          label: LabelString.labelDropLocation,
                          controller: dropLocationController,
                          hintText: LabelString.labelEnterDropLocation,
                        ),
                        3.verticalSpace,
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            LabelString.labelNearbyHospital,
                            style: GoogleFonts.dmSans(color: AppColors.blueColor, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
          CustomButton(onPressed: () {}, text: LabelString.labelConfirmLocation),
        ],
      ),
    );
  }
}

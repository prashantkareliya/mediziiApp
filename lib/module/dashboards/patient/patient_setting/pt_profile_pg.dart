import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/main.dart';

class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({super.key});

  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  final TextEditingController nameCtrl = TextEditingController(text: "Robin Roy");
  final TextEditingController emailCtrl = TextEditingController(text: "robinroy@gmail.com");
  final TextEditingController phoneCtrl = TextEditingController(text: "58745 42478");

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: LabelString.labelProfile, isBack: true),
      body: Padding(
        padding: EdgeInsets.all(18.sp),
        child: Column(
          children: [
            Container(
              height: 110.h,
              width: 110.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("https://images.pexels.com/photos/6129659/pexels-photo-6129659.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment(1.2, 1.2),
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
                  child: Icon(Icons.edit),
                ),
              ),
            ),
            40.verticalSpace,
            CustomTextField(
              label: LabelString.labelFullName,
              hintText: LabelString.labelEnterName,
              controller: nameCtrl,
              textInputType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ErrorString.emailAddressErr;
                }
                return null;
              },
            ),
            CustomTextField(
              label: LabelString.labelEmailAddress,
              hintText: LabelString.labelEnterEmailAddress,
              controller: emailCtrl,
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ErrorString.emailAddressErr;
                } else if (!emailCtrl.text.isValidEmail) {
                  return ErrorString.emailAddressValidErr;
                }
                return null;
              },
            ),
            CustomTextField(
              label: LabelString.labelPhoneNumber,
              hintText: LabelString.labelEnterPhoneNumber,
              controller: phoneCtrl,
              textInputType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ErrorString.emailAddressErr;
                }
                return null;
              },
            ),
            20.verticalSpace,
            CustomButton(
              onPressed: () {
                navigationService.pop();
              },
              text: LabelString.labelUpdate,
            ),
          ],
        ),
      ),
    );
  }
}

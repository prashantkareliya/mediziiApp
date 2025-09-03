import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';

class DoctorPatientPage extends StatefulWidget {
  const DoctorPatientPage({super.key});

  @override
  State<DoctorPatientPage> createState() => _DoctorPatientPageState();
}

class _DoctorPatientPageState extends State<DoctorPatientPage> {
  TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> profiles = [
    {"name": "Roger Siphorn", "image": "https://i.pravatar.cc/150?img=1"},
    {"name": "Lewis Sipes", "image": "https://i.pravatar.cc/150?img=2"},
    {"name": "Yvonne Klehn", "image": "https://i.pravatar.cc/150?img=3"},
    {"name": "Seth Herzog", "image": "https://i.pravatar.cc/150?img=4"},
    {"name": "Alfred Hammes", "image": "https://i.pravatar.cc/150?img=1"},
    {"name": "Francesco Boyle", "image": "https://i.pravatar.cc/150?img=2"},
    {"name": "Mildred Osinski", "image": "https://i.pravatar.cc/150?img=3"},
    {"name": "Alberta Cruickshank I", "image": "https://i.pravatar.cc/150?img=4"},
    {"name": "Doris Breitenberg", "image": "https://i.pravatar.cc/150?img=2"},
    {"name": "Ricky Shields", "image": "https://i.pravatar.cc/150?img=2"},
    {"name": "Jessie Cole", "image": "https://i.pravatar.cc/150?img=2"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: LabelString.labelPatient, rightWidget: null),

      body: Padding(
        padding: EdgeInsets.fromLTRB(18.sp, 0.sp, 18.sp, 18.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.verticalSpace,
            Text(
              LabelString.labelSearchPatient,
              style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: GoogleFontWeight.semiBold, color: AppColors.redColor),
            ),
            4.verticalSpace,
            CustomTextField(
              label: "",
              controller: searchController,
              suffixIcon: Padding(
                padding: EdgeInsets.all(12.sp),
                child: Assets.icIcons.search.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
              ),
              hintText: LabelString.labelSearchHint,
            ),
            8.verticalSpace,
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.sp,
                  mainAxisSpacing: 10.sp,
                  childAspectRatio: 0.8,
                ),
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){},
                    child: Column(
                      children: [
                        ClipOval(child: Image.network(profiles[index]["image"]!, height: 80, width: 80, fit: BoxFit.cover)),
                        8.verticalSpace,
                        Text(
                          profiles[index]["name"]!,
                          style: GoogleFonts.dmSans(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

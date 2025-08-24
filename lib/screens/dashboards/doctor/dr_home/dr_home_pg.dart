import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  final List<Map<String, String>> patients = [
    {"name": "Roger Siphorn", "id": "#212", "date": "25 Jan 2025", "image": "https://i.pravatar.cc/150?img=1"},
    {"name": "Gretchen Hermiston", "id": "#212", "date": "25 Jan 2025", "image": "https://i.pravatar.cc/150?img=2"},
    {"name": "Charles Dietrich", "id": "#212", "date": "25 Jan 2025", "image": "https://i.pravatar.cc/150?img=3"},
    {"name": "Denise Schaefer", "id": "#212", "date": "25 Jan 2025", "image": "https://i.pravatar.cc/150?img=4"},
    {"name": "Roger Siphorn", "id": "#212", "date": "25 Jan 2025", "image": "https://i.pravatar.cc/150?img=1"},
    {"name": "Gretchen Hermiston", "id": "#212", "date": "25 Jan 2025", "image": "https://i.pravatar.cc/150?img=2"},
    {"name": "Charles Dietrich", "id": "#212", "date": "25 Jan 2025", "image": "https://i.pravatar.cc/150?img=3"},
    {"name": "Denise Schaefer", "id": "#212", "date": "25 Jan 2025", "image": "https://i.pravatar.cc/150?img=4"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/dr_home_bg.png"), fit: BoxFit.fill)),
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                25.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40.sp,
                      width: 40.sp,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor, // Border color
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.whiteColor, width: 2),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://www.careerstaff.com/wp-content/uploads/2024/04/how-to-improve-patient-experience-satisfaction-scores.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Assets.icIcons.notification.svg(colorFilter: ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn)),
                    ),
                  ],
                ),
                20.verticalSpace,
                Text(
                  LabelString.labelGoodMorning,
                  style: GoogleFonts.dmSans(color: AppColors.whiteColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                3.verticalSpace,
                Text('Nina Decosta', style: GoogleFonts.dmSans(color: AppColors.whiteColor, fontSize: 24.sp, fontWeight: FontWeight.w600)),
              ],
            ),
          ),

          16.verticalSpace,
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LabelString.labelPatientsSummary, style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
                      Text(LabelString.labelViewAll, style: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.red)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 10.sp),
                    itemCount: patients.length,
                    separatorBuilder: (_, __) => 12.verticalSpace,
                    itemBuilder: (context, index) {
                      final patient = patients[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.greyBg,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(patient["image"]!, height: 45.sp, width: 45.sp, fit: BoxFit.cover),
                          ),
                          title: Text(patient["name"]!, style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                          subtitle: Row(
                            children: [
                              Text("ID: ${patient["id"]}", style: GoogleFonts.dmSans(fontSize: 12.sp, color: Colors.black54)),
                              6.horizontalSpace,
                              Text("•", style: TextStyle(color: Colors.red, fontSize: 12.sp)),
                              6.horizontalSpace,
                              Text(patient["date"]!, style: GoogleFonts.dmSans(fontSize: 12.sp, color: Colors.black54)),
                            ],
                          ),
                          trailing: Container(
                            padding: EdgeInsets.all(4.sp),
                            decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                            child: Icon(Icons.arrow_forward_ios_rounded, color: AppColors.redColor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

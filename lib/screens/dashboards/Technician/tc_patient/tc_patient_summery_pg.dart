import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/main.dart';
import 'package:medizii/screens/dashboards/Technician/tc_patient/tc_summery_detail_pg.dart';

class TechnicianPatientSummeryPage extends StatefulWidget {
  const TechnicianPatientSummeryPage({super.key});

  @override
  State<TechnicianPatientSummeryPage> createState() => _TechnicianPatientSummeryPageState();
}

class _TechnicianPatientSummeryPageState extends State<TechnicianPatientSummeryPage> {
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
      appBar: CustomAppBar(
        title: LabelString.labelPatientsSummary,
        isBack: true,
        rightWidget: Container(
          padding: EdgeInsets.all(6.sp),
          decoration: BoxDecoration(color: AppColors.gray.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(25)),
          child: Icon(Icons.swap_vert, color: AppColors.blackColor, size: 24),
        ),
      ),
      body: ListView.separated(
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
              onTap: (){
                navigationService.push(TechnicianSummeryDetailPg());
              },
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
    );
  }
}

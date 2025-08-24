import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';

class Doctor {
  final String name;
  final String specialty;
  final String imagePath;

  Doctor({required this.name, required this.specialty, required this.imagePath});
}

class PatientCallDrPage extends StatefulWidget {
  PatientCallDrPage({super.key});

  @override
  State<PatientCallDrPage> createState() => _PatientCallDrPageState();
}

class _PatientCallDrPageState extends State<PatientCallDrPage> {
  String selectedSpecialty = 'Cardiologist';

  final List<String> specialties = ['Cardiologist', 'Dentist', 'Gastroenterologist', 'Pediatrician'];

  final List<Doctor> doctors = [
    Doctor(name: 'Dr. Nene Rey', specialty: 'Cardiologist', imagePath: 'assets/doctor1.jpg'),
    Doctor(name: 'Dr. Nene Rey', specialty: 'Dentist', imagePath: 'assets/doctor2.jpg'),
    Doctor(name: 'Dr. Alison Larkin', specialty: 'Gastroenterologist', imagePath: 'assets/doctor3.jpg'),
    Doctor(name: 'Dr. Den Hermann', specialty: 'Urologist', imagePath: 'assets/doctor4.jpg'),
    Doctor(name: 'Dr. Theresa Feeney', specialty: 'Dentist', imagePath: 'assets/doctor5.jpg'),
    Doctor(name: 'Dr. Reginald Romag', specialty: 'Cardiologist', imagePath: 'assets/doctor6.jpg'),
    Doctor(name: 'Dr. Alison Larkin', specialty: 'Gastroenterologist', imagePath: 'assets/doctor7.jpg'),
  ];

  TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> selectedSpecialtyNotifier = ValueNotifier<String>('Cardiologist');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: LabelString.labelCallDoctor,
        isNotification: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LabelString.labelLookingDoctor,
              style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
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
            4.verticalSpace,

            SizedBox(
              height: 32.sp,
              child: ValueListenableBuilder<String>(
                valueListenable: selectedSpecialtyNotifier,
                builder: (context, selectedSpecialty, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: specialties.length,
                    itemBuilder: (context, index) {
                      bool isSelected = specialties[index] == selectedSpecialty;
                      return GestureDetector(
                        onTap: () {
                          selectedSpecialtyNotifier.value = specialties[index];
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 12.sp),
                          padding: EdgeInsets.symmetric(horizontal: 14.sp),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.blueColor.withValues(alpha: 0.1) : AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isSelected ? AppColors.transparent : AppColors.gray.withValues(alpha: 0.2)),
                          ),
                          child: Center(
                            child: Text(
                              specialties[index],
                              style: GoogleFonts.dmSans(
                                color: isSelected ? AppColors.blueColor : AppColors.blackColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            12.verticalSpace,
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  return DoctorCard(doctor: doctors[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      padding: EdgeInsets.all(13.sp),
      decoration: BoxDecoration(
        color: AppColors.greyBg,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50.sp,
            height: 50.sp,
            decoration: BoxDecoration(shape: BoxShape.circle, color: _getAvatarColor(doctor.name)),
            child: Center(
              child: Text(
                doctor.name.split(' ')[1][0], // First letter of last name
                style: GoogleFonts.dmSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          13.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.name, style: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor)),
                2.verticalSpace,
                Text(doctor.specialty, style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
              ],
            ),
          ),

          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Calling ${doctor.name}...')));
                },
                child: Container(
                  decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                  padding: EdgeInsets.all(6.sp),
                  child: Assets.icIcons.call.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                ),
              ),
              10.horizontalSpace,
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Starting video call with ${doctor.name}...')));
                },
                child: Container(
                  decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                  padding: EdgeInsets.all(6.sp),
                  child: Assets.icIcons.video.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.blue.shade400,
      Colors.green.shade400,
      Colors.orange.shade400,
      Colors.purple.shade400,
      Colors.teal.shade400,
      Colors.indigo.shade400,
    ];

    return colors[name.hashCode % colors.length];
  }
}

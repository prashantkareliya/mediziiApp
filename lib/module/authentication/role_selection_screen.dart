import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';

import 'auth_provider.dart';
import 'auth_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  RoleSelectionScreen({super.key});

  final List<String> roles = ['Doctor', 'Patient', 'Technician'];

  @override
  Widget build(BuildContext context) {
    final selectedRole = context.watch<AuthProvider>().selectedRole;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.expand, children: [Assets.images.bg.image(fit: BoxFit.fill), _buildRoleSelection(context, selectedRole)]),
    );
  }

  Widget _buildRoleSelection(BuildContext context, String selectedRole) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.sp),
      child: Column(
        children: [
          105.verticalSpace,
          Text(
            LabelString.labelJoinAs,
            style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
          ),
          20.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(14.r)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  roles
                      .map(
                        (role) =>
                            Padding(padding: EdgeInsets.symmetric(vertical: 6.sp), child: _buildRoleOption(context, role, selectedRole)),
                      )
                      .toList(),
            ),
          ),
          20.verticalSpace,
          CustomButton(
            width: context.width() * 0.8,
            height: 45.h,
            text: LabelString.labelContinue,
            onPressed: () {
              navigationService.push(AuthScreen(true, selectedRole: selectedRole));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoleOption(BuildContext context, String role, String selectedRole) {
    return GestureDetector(
      onTap: () => context.read<AuthProvider>().setSelectedRole(role),
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(role, style: GoogleFonts.dmSans(color: AppColors.black, fontSize: 18.sp)),
              Radio<String>(
                value: role,
                groupValue: selectedRole,
                activeColor: AppColors.redColor,
                onChanged: (value) => context.read<AuthProvider>().setSelectedRole(value!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

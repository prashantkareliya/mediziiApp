import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/authentication/register_page.dart';

import 'login_page.dart';

class AuthScreen extends StatefulWidget {
  bool check = true;

  String? selectedRole;

  AuthScreen(this.check, {super.key, this.selectedRole});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double getContainerHeight(BuildContext context) {
    if (_tabController.index == 0) {
      return MediaQuery.of(context).size.height * 0.32;
    } else {
      return MediaQuery.of(context).size.height * 0.58;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        extendBody: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Assets.images.bg.image(fit: BoxFit.fill),
            ListView(
              children: [
                if (widget.check)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        navigationService.pop();
                      },
                    ),
                  ),
                30.verticalSpace,
                Text(
                  textAlign: TextAlign.center,
                  LabelString.labelWelcomeTo,
                  style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
                ),
                20.verticalSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.sp),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(color: AppColors.grey.shade100, borderRadius: BorderRadius.circular(14.r)),
                  child: Column(
                    children: [
                      Container(
                        height: 65.sp,
                        margin: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(30.r)),
                        child: TabBar(
                          controller: _tabController,
                          dividerColor: AppColors.transparent,
                          labelStyle: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: GoogleFontWeight.semiBold),
                          labelColor: AppColors.redColor,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            color: AppColors.redColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.all(6.sp),
                          tabs: [Tab(text: LabelString.labelLogin), Tab(text: LabelString.labelRegister)],
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: getContainerHeight(context),
                        margin: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 10),

                        child: TabBarView(controller: _tabController, children: [LoginTab(widget.selectedRole), RegisterTab(widget.selectedRole)]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
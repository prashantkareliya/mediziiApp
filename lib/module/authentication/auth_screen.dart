import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/main.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin{
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
      return MediaQuery.of(context).size.height * 0.3;
    } else {
      return MediaQuery.of(context).size.height * 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            30.verticalSpace,
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  navigationService.pop();
                },
              ),
            ),
            50.verticalSpace,
            Text(
              LabelString.labelWelcomeTo,
              style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
            ),
            20.verticalSpace,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.sp),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: AppColors.grey.shade100,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                children: [
                  Container(
                    height: 65.sp,
                    margin: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      dividerColor:AppColors.transparent,
                      labelStyle: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: GoogleFontWeight.semiBold),
                      labelColor: AppColors.redColor,
                      unselectedLabelColor: Colors.black,
                      indicator: BoxDecoration(
                        color: AppColors.redColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.all(6.sp),
                      tabs: [
                        Tab(text: LabelString.labelLogin),
                        Tab(text: LabelString.labelRegister),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: getContainerHeight(context),
                    margin: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 10),

                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        LoginTab(),
                        RegisterTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

// ----------------- Login Tab ----------------- //

class LoginTab extends StatelessWidget {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  LoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailCtrl,
            decoration: InputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter Email Address',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passCtrl,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter Password',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              suffixIcon: Icon(Icons.visibility_off),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: StadiumBorder(),
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}

// ----------------- Register Tab ----------------- //

class RegisterTab extends StatelessWidget {
  final List<String> roles = ['Doctor', 'Patient', 'Technician'];
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  RegisterTab({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedRole = 'Select';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: StatefulBuilder(builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Choose Role',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                value: selectedRole == 'Select' ? null : selectedRole,
                hint: Text('Select'),
                items: roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedRole = value ?? 'Select');
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter Email Address',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneCtrl,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter Phone Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: StadiumBorder(),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Register Now"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}

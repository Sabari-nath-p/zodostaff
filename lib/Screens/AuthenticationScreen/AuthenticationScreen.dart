import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/AppointmentListScreen.dart';
import 'package:zodostaff/Screens/AuthenticationScreen/Services/AuthController.dart';
import 'package:zodostaff/Utils/CustomAlerts.dart';

class AuthenticationScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Obx(
          () => Container(
            height: 60.h,
            margin: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
            alignment: Alignment.bottomCenter,
            child: CustomButton(
              text: 'Sign In',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  authController.login();
                }
              },
              isLoading: authController.isLoading.value,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 120.h),
                  // Logo Section
                  Center(
                    child: Image.asset(
                      "Assets/Icons/zodo_icon.png",
                      height: 80.w,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  // Welcome Text
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Sign in to your staff account',
                    style: TextStyle(fontSize: 16.sp, color: Color(0xFF7F8C8D)),
                  ),
                  SizedBox(height: 40.h),
                  // Email Field
                  CustomTextField(
                    controller: authController.emailController,
                    label: 'Email Address',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    validator: authController.validateEmail,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  // Password Field
                  Obx(
                    () => CustomTextField(
                      controller: authController.passwordController,
                      label: 'Password',
                      hint: 'Enter your password',
                      isPassword: true,
                      isObscured: !authController.isPasswordVisible.value,
                      onToggleVisibility:
                          authController.togglePasswordVisibility,
                      validator: authController.validatePassword,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                  // SizedBox(height: 16.h),
                  // // Forgot Password Link
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       'Forgot Password?',
                  //       style: TextStyle(
                  //         color: Color(0xFF4CAF50),
                  //         fontSize: 14.sp,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

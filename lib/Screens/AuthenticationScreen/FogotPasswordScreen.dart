import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:zodostaff/Screens/AuthenticationScreen/Services/AuthController.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF2C3E50)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                // Icon
                Center(
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_reset,
                      size: 50.sp,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                // Title
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Enter your email address and we\'ll send you an OTP to reset your password.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF7F8C8D),
                    height: 1.5,
                  ),
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
                SizedBox(height: 40.h),
                // Send OTP Button
                Obx(
                  () => CustomButton(
                    text: 'Send OTP',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authController.forgotPassword();
                      }
                    },
                    isLoading: authController.isLoading.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

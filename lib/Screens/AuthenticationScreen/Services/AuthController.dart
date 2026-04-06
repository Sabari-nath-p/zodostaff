import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zodostaff/Screens/HomeScreens/HomeScreen.dart';
import 'package:zodostaff/Utils/Colors.dart';
import 'package:zodostaff/Utils/apiHandler.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var otpTimer = 60.obs;
  var canResendOTP = false.obs;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> login() async {
    if (validateEmail(emailController.text) == null &&
        validatePassword(passwordController.text) == null) {
      isLoading.value = true;
      ApiService.request(
        endpoint: "auth/login",
        requiresAuth: false,
        body: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
        onSuccess: (data) async {
          isLoading.value = false;

          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("AUTHKEY", data.data["data"]["tokens"]["accessToken"]);
          pref.setString("LOGIN", "IN");
          Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
          print(data.data);
        },
        onUnauthenticated: () {
          isLoading.value = false;
          Fluttertoast.showToast(msg: "Invalid credentials ");
        },
        onError: (error) {
          isLoading.value = false;
        },
        headers: {"app-type": "staff"},
      );
    }
  }

  Future<void> forgotPassword() async {
    if (validateEmail(emailController.text) == null) {
      isLoading.value = true;
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      isLoading.value = false;
      Get.toNamed('/otp-verification');
      Get.snackbar(
        'OTP Sent',
        'OTP has been sent to your email',
        backgroundColor: Color(0xFF4CAF50),
        colorText: Colors.white,
      );
      startOTPTimer();
    }
  }

  Future<void> verifyOTP() async {
    if (validateOTP(otpController.text) == null) {
      isLoading.value = true;
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      isLoading.value = false;
      Get.toNamed('/reset-password');
    }
  }

  Future<void> resetPassword() async {
    if (validatePassword(newPasswordController.text) == null &&
        validateConfirmPassword(confirmPasswordController.text) == null) {
      isLoading.value = true;
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      isLoading.value = false;
      Get.offAllNamed('/login');
      Get.snackbar(
        'Success',
        'Password reset successfully!',
        backgroundColor: Color(0xFF4CAF50),
        colorText: Colors.white,
      );
      clearControllers();
    }
  }

  void startOTPTimer() {
    otpTimer.value = 60;
    canResendOTP.value = false;
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      otpTimer.value--;
      if (otpTimer.value == 0) {
        canResendOTP.value = true;
        return false;
      }
      return true;
    });
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    otpController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    super.onClose();
  }
}

// Custom Widgets
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isPassword;
  final bool isObscured;
  final VoidCallback? onToggleVisibility;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final double? height;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.isObscured = false,
    this.onToggleVisibility,
    this.height,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C3E50),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          obscureText: isObscured,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.done,
          validator: validator,
          style: TextStyle(fontSize: 16.sp),
          //   maxLines: null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14.sp),
            prefixIcon: prefixIcon,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility,
                      color: Color(0xFF9E9E9E),
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.PrimaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Color(0xFFE53E3E)),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.PrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? Colors.white,
                ),
              ),
      ),
    );
  }
}

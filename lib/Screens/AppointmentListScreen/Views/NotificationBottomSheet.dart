import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Service/AppointmentController.dart';
import 'package:zodostaff/Screens/AuthenticationScreen/Services/AuthController.dart';
import 'package:zodostaff/Utils/Colors.dart';
import 'package:zodostaff/Utils/CustomAlerts.dart';

class NotificationBottomSheet extends StatelessWidget {
  NotificationBottomSheet({super.key});
  TextEditingController titleText = TextEditingController();
  TextEditingController bodyText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      builder: (__) {
        return Container(
          width: double.infinity,
          height: 470.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80.h,
                padding: EdgeInsets.all(16.w),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: AppColors.PrimaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Text(
                  "Appointment Notification",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: titleText,
                          label: "Notification Title",
                          hint: "Title of the notification",
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          constraints: BoxConstraints(minHeight: 170.h),
                          child: CustomTextField(
                            controller: bodyText,
                            label: "Notification Body",
                            hint: "Message of the notification",
                          ),
                        ),
                        SizedBox(height: 20.h),

                        CustomButton(
                          text: 'Sign In',
                          onPressed: () {
                            if (titleText.text.isNotEmpty &&
                                bodyText.text.isNotEmpty) {
                              __.TiggerNotification(
                                titleText.text,
                                bodyText.text,
                              );
                            } else {
                              Customalerts.successAlert(
                                title: "Missing Field",
                                body: "Fill both fields to send data",
                              );
                            }
                          },
                          isLoading: __.isNotificationLoading,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

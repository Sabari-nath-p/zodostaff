import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Service/AppointmentController.dart';
import 'package:zodostaff/Screens/HomeScreens/Service/HomeController.dart';
import 'package:zodostaff/Screens/ProfileScreen/ProfileScreen.dart';
import 'package:zodostaff/Utils/Colors.dart';

class Htopcard extends StatelessWidget {
  Htopcard({super.key});
  HomeController hctrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      color: AppColors.PrimaryColor,
      //margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 140.h,
      padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w),
      child: Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder:
                        (context) =>
                            ProfileBottomSheetContent(userProfile: hctrl.user!),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Image.network(
                      hctrl.user!.profilePicture ?? "",
                      fit: BoxFit.cover,
                      height: 52.w,
                      width: 52.w,
                      errorBuilder:
                          (context, error, stackTrace) => Opacity(
                            opacity: .7,
                            child: Image.asset(
                              'Assets/Icons/zodo_icon_only.png',
                              fit: BoxFit.contain,
                              height: 40.w,
                              width: 40.w,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, ${hctrl.user!.firstName ?? ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${hctrl.hospitalName} | ${hctrl.user!.jobTitle ?? ""}",
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,

                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset("Assets/Icons/zodo_icon.png", width: 80.w),
            ],
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

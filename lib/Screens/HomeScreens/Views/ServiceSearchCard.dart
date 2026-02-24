import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/AppointmentListScreen.dart';
import 'package:zodostaff/Screens/HomeScreens/Model/SearchServiceModel.dart';
import 'package:zodostaff/Utils/Colors.dart';

class ServiceSearchCard extends StatelessWidget {
  ServiceListModel service;
  ServiceSearchCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361.w,
      height: 170.h,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        //color: AppColors.BgSecondary,
        border: Border.all(color: Color(0xffECECEC)),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.network(
                  service.image ?? "",
                  fit: BoxFit.cover,

                  errorBuilder:
                      (context, error, stackTrace) =>
                          Icon(Icons.image, color: Colors.grey.withOpacity(.5)),
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (service.hospital != null) SizedBox(height: 5.h),
                  if (service.hospital != null)
                    Text(
                      service.hospital!.name ?? "",
                      style: TextStyle(
                        color: AppColors.Hint2Color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  SizedBox(height: 5.h),
                ],
              ),
              SizedBox(height: 5.h),
            ],
          ),
          SizedBox(height: 8.h),
          Container(width: 336.w, height: 1.h, color: Color(0xffF5F5F5)),
          SizedBox(height: 18.h),
          Row(
            children: [
              Text(
                "Fees :",
                style: TextStyle(
                  color: AppColors.Hint2Color,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                " ₹ ${service.price}  ",
                style: TextStyle(
                  //     color: Color(0xff636363),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Expanded(child: Container()),
              SizedBox(height: 8.h),

              Container(
                width: 170.w,
                height: 33.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => AppointmentListScreen(
                        isService: true,
                        seaarchID: service.id,
                      ),
                    );
                  },
                  child: Text(
                    "View Appointment",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.BgSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // code here
        ],
      ),
    );
  }
}

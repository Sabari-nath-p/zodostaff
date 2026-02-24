import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/AppointmentListScreen.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Views/AppointmentBottomSheet.dart';
import 'package:zodostaff/Screens/HomeScreens/Model/doctorModel.dart';
import 'package:zodostaff/Utils/Colors.dart';

class DoctorSearchCard extends StatelessWidget {
  DoctorListModel doctor;

  DoctorSearchCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361.w,
      height: 140.h,
      padding: EdgeInsets.all(16.r),
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
                child:
                    (doctor.profilePic == null || doctor.profilePic == "")
                        ? Icon(Icons.image, color: Colors.grey)
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: Image.network(
                            doctor.profilePic!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.image,
                                color: Colors.grey.withOpacity(.6),
                              );
                            },
                          ),
                        ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    (doctor.specialisations == null ||
                            doctor.specialisations!.isEmpty)
                        ? "General Medicine"
                        : doctor.specialisations!.first!.name!,
                    style: TextStyle(
                      color: AppColors.Hint2Color,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Expanded(child: Container()),
              SizedBox(width: 12.w),
              // Text(
              //   doctor.workStartDate == null
              //       ? "1y exp"
              //       : Timeago.format(
              //             DateTime.parse(doctor.workStartDate!),
              //             locale: "en_short",
              //           ).replaceAll("ago", "year Exp") +
              //           " exp",
              //   style: TextStyle(
              //     color: AppColors.Hint2Color,
              //     fontSize: 14.sp,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(width: 336.w, height: 1.h, color: Color(0xffF5F5F5)),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                "Fees :",
                style: TextStyle(
                  color: AppColors.Hint2Color,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                " ₹${doctor.pricing ?? ""}",
                style: TextStyle(
                  color: Color(0xff636363),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(child: Container()),

              SizedBox(
                width: 170.w,
                height: 33.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => AppointmentListScreen(
                        seaarchID: doctor.id,
                        isDoctor: true,
                      ),
                    );
                  },
                  child: Text(
                    "View Appointments",
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
        ],
      ),
    );
  }
}

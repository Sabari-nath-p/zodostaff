import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Model/AppointmentModel.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Service/AppointmentController.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Views/AppointmentBottomSheet.dart';
import 'package:zodostaff/Utils/Colors.dart';

class BookingCard extends StatelessWidget {
  AppointmentModel historyModel;
  BookingCard({super.key, required this.historyModel});
  AppointmentController ctrl = Get.find();
  @override
  Widget build(BuildContext context) {
    String profilePicture = "";
    String name = "";
    String ageGender = "";
    String rating = "";
    String review = "";

    if (historyModel.userDetails != null) {
      name = historyModel.userDetails!.name ?? "";
      profilePicture = historyModel.user!.profilePicture ?? "";
      ageGender =
          "${historyModel!.userDetails!.gender!} | ${historyModel!.userDetails!.age!}";
    } else {
      name = historyModel.user!.firstName ?? "";
      profilePicture = historyModel.user!.profilePicture ?? "";
      ageGender =
          "${historyModel!.user!.gender!} | ${historyModel!.user!.age!}";
    }

    rating = ""; //historyModel.doctor!.avgRating ?? "0";
    review = ""; //(historyModel.doctor!.ratingCount ?? "0").toString();
    AppointmentController ctrl = Get.find();
    return Container(
      width: 360.w,
      // height: 200.h,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xffECECEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 75.w,
                height: 75.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    profilePicture,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "$ageGender",
                      style: TextStyle(
                        color: AppColors.Hint2Color,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.w),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffFAF9FF),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        historyModel.paymentType!,
                        style: TextStyle(
                          color:
                              (historyModel.status == "completed")
                                  ? Colors.orange
                                  : Colors.green,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
              SizedBox(height: 5.h),

              if (!ctrl.isFastTag)
                InkWell(
                  onTap: () {
                    ctrl.prescriptionImage.clear();
                    Get.bottomSheet(
                      AppointmentBottomSheet(
                        appointment: historyModel,
                        name: name,
                        agegender: ageGender,
                      ),
                    );
                  },
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              SizedBox(width: 10.w),
              Icon(
                Icons.calendar_month_outlined,
                color: AppColors.Hint2Color,
                size: 17.sp,
              ),

              Text(
                DateFormat("  EEE, dd MMM ").format(
                  DateTime.parse(historyModel.appointmentDate.toString()),
                ),
                style: TextStyle(
                  color: AppColors.Hint2Color,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (historyModel.timeSlot != null)
                Text(
                  DateFormat(
                    "| hh:mm a",
                  ).format(DateFormat.Hms().parse(historyModel.timeSlot ?? "")),
                  style: TextStyle(
                    color: AppColors.Hint2Color,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

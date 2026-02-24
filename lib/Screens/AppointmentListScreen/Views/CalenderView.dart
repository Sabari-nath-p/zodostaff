import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Service/AppointmentController.dart';
import 'package:zodostaff/Utils/Colors.dart';

class BookingCalenderView extends StatelessWidget {
  BookingCalenderView({super.key});

  List<_dateModel> dates = [];
  AppointmentController actrl = Get.find();

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.now().subtract(Duration(days: 1));
    for (int i = 0; i < 7; i++)
      dates.add(_dateModel.fromDate(startDate.add(Duration(days: i))));
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final isSelected =
              DateFormat.MEd().format(actrl.selectedDate) ==
              DateFormat.MEd().format(dates[index].dateTime!);
          return GestureDetector(
            onTap: () {
              actrl.selectedDate = dates[index].dateTime!;
              actrl.appointments.clear();
              actrl.fetchAppointment();
              actrl.update();
            },
            child: Container(
              width: 50.w,
              height: 63.h,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      isSelected
                          ? AppColors.PrimaryColor
                          : Colors.grey.shade300,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(20.r),
                color: isSelected ? Colors.white : Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dates[index].day,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isSelected ? AppColors.PrimaryColor : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    dates[index].date,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? AppColors.PrimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _dateModel {
  late String day;
  late String date;
  DateTime? dateTime;
  _dateModel({required this.date, required this.day});

  _dateModel.fromDate(DateTime date) {
    day = DateFormat("EEE").format(date).toString().capitalize!;
    this.date = DateFormat("dd").format(date).toString();
    dateTime = date;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Service/AppointmentController.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Views/BookingCard.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Views/CalenderView.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Views/NotificationBottomSheet.dart';
import 'package:zodostaff/Utils/Colors.dart';
import 'package:zodostaff/Utils/noDataWarning.dart';

class AppointmentListScreen extends StatelessWidget {
  AppointmentListScreen({
    super.key,
    this.isDoctor = false,
    this.isFastTag = false,
    this.isService = false,
    this.seaarchID,
  });

  bool isDoctor;
  bool isService;
  bool isFastTag;
  String? seaarchID;

  @override
  Widget build(BuildContext context) {
    AppointmentController actrl = Get.put(
      AppointmentController(
        seaarchID ?? "",
        isDoctor,
        isService,
        isFastTag,
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.teal,
              size: 20.sp,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Appointment List',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.bottomSheet(
                  NotificationBottomSheet(),
                  isScrollControlled: true,
                );
              },
              child: Icon(
                Icons.notification_add,
                color: AppColors.PrimaryColor,
              ),
            ),
            SizedBox(width: 20.w),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GetBuilder<AppointmentController>(
              builder: (__) {
                /// Loading
                if (__.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.PrimaryColor,
                    ),
                  );
                }

                /// ✅ FIXED LAYOUT
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Calendar
                    BookingCalenderView(),

                    SizedBox(height: 10.h),

                    /// Empty State
                    if (__.appointments.isEmpty)
                      NoDataWarning(
                        title: "No Appointments Available",
                        body:
                            "There are no available appointments\non the selected date.",
                        margin: 100.h,
                      ),

                    /// Appointment List
                    Expanded(
                      child: SmartRefresher(
                        controller: actrl.appointmentRefresh,
                        onRefresh: () {
                          if (isDoctor) {
                            actrl.appointments.clear();
                            actrl.fetchDoctorAppointment();
                          }
                        },
                        child: ListView.builder(
                          itemCount: actrl.appointments.length,
                          itemBuilder: (context, index) {
                            return BookingCard(
                              historyModel:
                                  actrl.appointments[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
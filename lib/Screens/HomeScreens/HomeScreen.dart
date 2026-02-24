import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:zodostaff/Screens/HomeScreens/Service/HomeController.dart';
import 'package:zodostaff/Screens/HomeScreens/Views/DoctorSearchCard.dart';
import 'package:zodostaff/Screens/HomeScreens/Views/HMenuView.dart';
import 'package:zodostaff/Screens/HomeScreens/Views/HtopCard.dart';
import 'package:zodostaff/Screens/HomeScreens/Views/ServiceSearchCard.dart';
import 'package:zodostaff/Utils/Colors.dart';
import 'package:zodostaff/Utils/noDataWarning.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeController hctrl = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (__) {
          return (__.user == null || __.isloading)
              ? Center(
                child: CircularProgressIndicator(color: AppColors.PrimaryColor),
              )
              : Column(
                spacing: 10.h,

                children: [
                  Htopcard(),
                  BMenuCard(),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextField(
                      controller: hctrl.searchController,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.SecondaryText,
                      ),
                      onSubmitted: (value) {
                        hctrl.page = 1;
                        hctrl.doctors = [];
                        hctrl.homeRefreshController.resetNoData();
                        hctrl.hospitalService = [];
                        if (hctrl.selectedMenu == 0) {
                          hctrl.fetchDoctors();
                        } else {
                          hctrl.fetchServices();
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search For Doctor",
                        contentPadding: EdgeInsets.only(right: 10.w),
                        suffixIconConstraints: BoxConstraints(maxWidth: 30.w),

                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  if (__.doctors.isEmpty && __.hospitalService.isEmpty)
                    NoDataWarning(
                      title: "No Result Found",
                      body: "",
                      margin: 60.h,
                    )
                  else
                    Expanded(
                      child: SmartRefresher(
                        controller: hctrl.homeRefreshController,
                        onRefresh: () {
                          //   hctrl.fetchHospital();
                          hctrl.fetchUser();
                          hctrl.homeRefreshController.resetNoData();
                          hctrl.page = 1;
                          if (hctrl.selectedMenu == 0) {
                            hctrl.doctors = [];
                            hctrl.fetchDoctors();
                          } else if (hctrl.selectedMenu == 1) {
                            hctrl.hospitalService = [];
                            hctrl.fetchServices();
                          }
                        },
                        enablePullUp: true,
                        onLoading: () {
                          if (hctrl.selectedMenu == 0) {
                            hctrl.fetchDoctors();
                          } else if (hctrl.selectedMenu == 1) {
                            hctrl.fetchServices();
                          }
                        },

                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 10.h,
                            children: [
                              if (hctrl.selectedMenu == 0)
                                for (var doctor in hctrl.doctors)
                                  DoctorSearchCard(doctor: doctor),

                              if (hctrl.selectedMenu == 1)
                                for (var service in hctrl.hospitalService)
                                  ServiceSearchCard(service: service),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
        },
      ),
    );
  }
}

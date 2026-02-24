import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/AppointmentListScreen.dart';
import 'package:zodostaff/Screens/HomeScreens/Service/HomeController.dart';

class BMenuCard extends StatelessWidget {
  BMenuCard({super.key});

  final Map<int, Widget> menus = <int, Widget>{
    0: SizedBox(
      width: 178.w,
      height: 46.h,
      child: Center(child: Text("Doctors")),
    ),
    1: SizedBox(
      width: 178.w,
      height: 46.h,
      child: Center(child: Text("Services")),
    ),
    2: SizedBox(
      width: 178.w,
      height: 46.h,
      child: Center(child: Text("Fast Tag")),
    ),
  };

  HomeController hctrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (__) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          width: 390.w,
          child: CupertinoSlidingSegmentedControl(
            proportionalWidth: true,
            children: menus,
            groupValue: hctrl.selectedMenu,

            onValueChanged: (value) {
              print(value);

              if (value == 2) {
                Get.to(() => AppointmentListScreen(isFastTag: true));
                return;
              } else {
                hctrl.searchController.clear();
                hctrl.selectedMenu = value ?? 0;
                hctrl.update();

                hctrl.homeRefreshController.resetNoData();
                hctrl.page = 1;
                if (hctrl.selectedMenu == 0) {
                  hctrl.doctors = [];
                  hctrl.fetchDoctors();
                } else if (hctrl.selectedMenu == 1) {
                  hctrl.hospitalService = [];
                  hctrl.fetchServices();
                }
              }
            },
          ),
        );
      },
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:zodostaff/Screens/HomeScreens/Model/HospitalModel.dart';
import 'package:zodostaff/Screens/HomeScreens/Model/SearchServiceModel.dart';
import 'package:zodostaff/Screens/HomeScreens/Model/UserModel.dart';
import 'package:zodostaff/Screens/HomeScreens/Model/doctorModel.dart';
import 'package:zodostaff/Utils/apiHandler.dart';

class HomeController extends GetxController {
  RefreshController homeRefreshController = RefreshController();
  UserModel? user;
  String hospitalName = "";
  HospitalModel? myHospital;
  String hospitalID = "";
  int selectedMenu = 0;
  int page = 1;
  List<DoctorListModel> doctors = [];
  List<ServiceListModel> hospitalService = [];
  bool isFirst = true;
  bool isloading = true;
  TextEditingController searchController = TextEditingController();
  fetchUser() {
    ApiService.request(
      endpoint: "auth/me",
      method: Api.GET,
      onSuccess: (data) {
        print(data);
        homeRefreshController.refreshCompleted();
        print(data.data);
        user = UserModel.fromJson(data.data["data"]["data"]);
        hospitalID = user!.hospitalId ?? "";
        update();
        fetchHospital(user!.hospitalId!);
        if (isFirst) {
          fetchDoctors();
          isFirst = false;
        }
      },
    );
  }

  fetchHospital(String hospitalID) {
    ApiService.request(
      endpoint: "hospitals/$hospitalID",
      method: Api.GET,
      onSuccess: (data) {
        myHospital = HospitalModel.fromJson(data.data);
        hospitalName = myHospital!.name ?? "";
        update();
      },
    );
  }

  fetchDoctors() {
    if (doctors.isEmpty) isloading = true;
    update();
    ApiService.request(
      endpoint:
          "doctors?hospital_id=${hospitalID}&page=$page&limit=20&name=${searchController.text.trim()}",
      method: Api.GET,
      onSuccess: (response) {
        if (response.statusCode == 200) {
          for (var data in response.data["data"]) {
            doctors.add(DoctorListModel.fromJson(data));
          }
          homeRefreshController.loadComplete();
          homeRefreshController.refreshCompleted();
          homeRefreshController.loadComplete();
          page = page + 1;
          if (response.data["data"].isEmpty) {
            homeRefreshController.loadNoData();
          }
          isloading = false;
          update();
        }
      },
    );
  }

  fetchServices() {
    if (hospitalService.isEmpty) isloading = true;
    update();
    ApiService.request(
      endpoint:
          "hospital-services?hospital_id=${hospitalID}&page=$page&limit=20&name=${searchController.text.trim()}",
      method: Api.GET,
      onSuccess: (response) {
        if (response.statusCode == 200) {
          for (var data in response.data["data"]) {
            hospitalService.add(ServiceListModel.fromJson(data));
          }
          homeRefreshController.loadComplete();
          homeRefreshController.refreshCompleted();
          homeRefreshController.loadComplete();
          page = page + 1;
          if (response.data["data"].isEmpty) {
            homeRefreshController.loadNoData();
          }
          isloading = false;

          update();
        }
      },
    );
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await fetchUser();
  }
}

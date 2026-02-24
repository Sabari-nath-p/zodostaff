import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Model/AppointmentModel.dart';
import 'package:zodostaff/Screens/HomeScreens/Service/HomeController.dart';
import 'package:zodostaff/Utils/Utils.dart';
import 'package:zodostaff/Utils/apiHandler.dart';

class AppointmentController extends GetxController {
  DateTime selectedDate = DateTime.now();
  bool isDoctor = false;
  bool isService = false;
  bool isFastTag = false;
  bool isLoading = true;
  bool isNotificationLoading = false;
  String searchID = "";
  RefreshController appointmentRefresh = RefreshController();
  List<AppointmentModel> appointments = [];
  bool isMarkLoading = false;
  HomeController hctrl = Get.find();

  List<XFile> prescriptionImage = [];
  AppointmentController(String sId, bool isDoc, bool isSer, bool isFa) {
    isDoctor = isDoc;
    isService = isSer;
    isFastTag = isFa;
    searchID = sId;
    fetchAppointment();
  }

  fetchDoctorAppointment() {
    isLoading = true;
    update();
    ApiService.request(
      endpoint:
          "bookings/doctor/$searchID/bookings?to_date=${DateFormat("yyyy-MM-dd").format(selectedDate)}&from_date=${DateFormat("yyyy-MM-dd").format(selectedDate)}&limit=100&page=1&status=accepted",
      method: Api.GET,
      onSuccess: (response) {
        print(response.data);

        for (var data in response.data["data"]) {
          isLoading = false;
          update();
          appointments.add(AppointmentModel.fromJson(data));
        }
        appointmentRefresh.refreshCompleted();
        isLoading = false;
        update();
      },
    );
  }

  fetchServiceAppointment() async {
    isLoading = true;
    update();
    await ApiService.request(
      endpoint:
          "bookings/hospital/${hctrl.hospitalID}/bookings?to_date=${DateFormat("yyyy-MM-dd").format(selectedDate)}&from_date=${DateFormat("yyyy-MM-dd").format(selectedDate)}&limit=100&page=1&status=accepted",
      method: Api.GET,
      onSuccess: (response) {
        print(response.data);

        for (var data in response.data["data"]) {
          final tempModel = AppointmentModel.fromJson(data);
          if (tempModel.hospitalServiceId == searchID ||
              (isFastTag && tempModel.type == 'fast_tag'))
            appointments.add(tempModel);
        }
        appointmentRefresh.refreshCompleted();
        update();
      },
      onError: (e) {
        print(e);
      },
    );
    isLoading = false;
    update();
  }

  fetchFastTags() {}

  fetchAppointment() {
    if (isDoctor) {
      fetchDoctorAppointment();
    } else {
      fetchServiceAppointment();
    }
  }

  TiggerNotification(String title, String body) async {
    isNotificationLoading = true;
    update();
    await ApiService.request(
      endpoint: "notifications",
      body: {
        "user_ids":
            appointments.map((data) {
              return data.user!.id!;
            }).toList(),
        "title": title,
        "body": body,
        "type": ["in_app", "push"],
      },
      onSuccess: (resposne) {
        print(resposne.data);
        Get.back();
      },
    );
    isNotificationLoading = false;
    update();
  }

  markAppointmentComplete(String bookingId) async {
    isMarkLoading = true;
    update();
    List imageKey = [];
    if (prescriptionImage.isNotEmpty) {
      for (var img in prescriptionImage) {
        String? temp = await fileUpload(img.path, isKey: true);
        if (temp != null) {
          imageKey.add(temp);
        }
      }
    }

    await ApiService.request(
      endpoint: "booking-prescriptions",
      method: Api.POST,
      body: {
        "booking_id": "$bookingId",
        "files": [for (var data in imageKey) data.toString()],
      },
      onSuccess: (data) async {
        print(data.data);

        if (data.statusCode == 201) {
          isMarkLoading = false;
          appointments.clear();
          fetchAppointment();
          update();
          Get.back();
        }

        // await ApiService.request(
        //   endpoint: "bookings/$bookingId/mark-complete",
        //   method: Api.PATCH,
        //   onSuccess: (response) {
        //     print(response.data);
        //     isMarkLoading = false;
        //     appointments.clear();
        //     fetchAppointment();
        //     update();
        //     Get.back();
        //   },
        // );
      },
    );
  }
}

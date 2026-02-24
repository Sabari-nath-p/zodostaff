import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Model/AppointmentModel.dart';
import 'package:zodostaff/Screens/AppointmentListScreen/Service/AppointmentController.dart';
import 'package:zodostaff/Utils/Colors.dart';
import 'package:zodostaff/Utils/CustomAlerts.dart';

class AppointmentBottomSheet extends StatelessWidget {
  AppointmentModel appointment;
  String name, agegender;
  AppointmentBottomSheet({
    super.key,
    required this.appointment,
    required this.agegender,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: .5.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.PrimaryColor.withOpacity(.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: AppColors.PrimaryColor.withOpacity(.2),
                  child: Text(
                    name!.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.PrimaryColor.withOpacity(.7),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$agegender years',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 24.sp),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAttachmentSection(),
                  SizedBox(height: 20.h),
                  _buildActionButtons(appointment),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildAttachmentSection() {
  return GetBuilder<AppointmentController>(
    builder: (__) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attachments',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              //   color: AppColors.PrimaryColor.withOpacity(.7),
            ),
          ),
          SizedBox(height: 8.h),
          Card(
            color: AppColors.PrimaryColor.withOpacity(.1),
            shadowColor: Colors.transparent,

            child: Container(
              height: 200.h,
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      AppointmentController actrl = Get.find();

                      if (actrl.prescriptionImage.length == 3) {
                        Customalerts.warningAlert(
                          title: "Maximum 3 image can be uploaded",
                        );
                        return;
                      }
                      final ImagePicker picker = ImagePicker();

                      final XFile? image = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 60,
                      );
                      if (image != null) {
                        actrl.prescriptionImage.add(image);
                        actrl.update();
                      }
                    },
                    icon: Icon(Icons.camera_alt, size: 20.sp),
                    label: Text('Attach Image from Camera'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryColor.withOpacity(.6),
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 45.h),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  if (__.prescriptionImage.isNotEmpty)
                    Text("Double tap on the image to remove it"),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 10.w,
                    children: [
                      for (var data in __.prescriptionImage)
                        InkWell(
                          onDoubleTap: () {
                            __.prescriptionImage.remove(data);
                            __.update();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: Image.file(
                              File(data.path),
                              fit: BoxFit.cover,
                              width: 60.w,
                              height: 60.h,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (__.prescriptionImage.isEmpty)
                    Container(
                      height: 100.h,
                      alignment: Alignment.center,
                      child: Text(
                        'No attachments yet',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildActionButtons(AppointmentModel model) {
  return GetBuilder<AppointmentController>(
    builder: (__) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (!__.isMarkLoading)
                      __.markAppointmentComplete(model.id!);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.PrimaryColor.withOpacity(.7),
                    foregroundColor: Colors.white,
                    minimumSize: Size(0, 45.h),
                  ),
                  child:
                      (__.isMarkLoading)
                          ? LoadingAnimationWidget.stretchedDots(
                            color: Colors.white,
                            size: 24.w,
                          )
                          : Text('Mark Complete'),
                ),
              ),
              // SizedBox(width: 12.w),
              // Expanded(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Get.back();
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.red,
              //       foregroundColor: Colors.white,
              //       minimumSize: Size(0, 45.h),
              //     ),
              //     child: Text('Mark Incomplete'),
              //   ),
              // ),
            ],
          ),
        ],
      );
    },
  );
}

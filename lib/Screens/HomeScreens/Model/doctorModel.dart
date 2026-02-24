import 'package:zodostaff/Screens/HomeScreens/Model/HospitalModel.dart';
import 'package:zodostaff/Screens/HomeScreens/Model/SpecialisationModel.dart';

class DoctorListModel {
  String? id;
  String? profilePic;
  String? name;
  String? email;
  String? city;
  String? status;
  String? hospitalId;
  String? userId;
  String? phoneNumber;
  String? pricing;
  String? workStartDate;
  String? totalRating;
  String? avgRating;
  int? ratingCount;
  HospitalModel? hospital;
  List<SpecialisationModel>? specialisations;

  DoctorListModel({
    this.id,
    this.profilePic,
    this.name,
    this.email,
    this.city,
    this.status,
    this.hospitalId,
    this.userId,
    this.phoneNumber,
    this.pricing,
    this.workStartDate,
    this.totalRating,
    this.avgRating,
    this.ratingCount,
    this.hospital,
    this.specialisations,
  });

  DoctorListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePic = json['profile_pic'];
    name = json['name'];
    email = json['email'];
    city = json['city'];
    status = json['status'];
    hospitalId = json['hospital_id'];
    userId = json['user_id'];
    phoneNumber = json['phone_number'];
    pricing = json['pricing'];
    workStartDate = json['work_start_date'];
    totalRating = json['total_rating'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    hospital =
        json['hospital'] != null
            ? new HospitalModel.fromJson(json['hospital'])
            : null;
    if (json['specialisations'] != null) {
      specialisations = <SpecialisationModel>[];
      json['specialisations'].forEach((v) {
        specialisations!.add(new SpecialisationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    data['email'] = this.email;
    data['city'] = this.city;
    data['status'] = this.status;
    data['hospital_id'] = this.hospitalId;
    data['user_id'] = this.userId;
    data['phone_number'] = this.phoneNumber;
    data['pricing'] = this.pricing;
    data['work_start_date'] = this.workStartDate;
    data['total_rating'] = this.totalRating;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    if (this.hospital != null) {
      data['hospital'] = this.hospital!.toJson();
    }
    if (this.specialisations != null) {
      data['specialisations'] =
          this.specialisations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

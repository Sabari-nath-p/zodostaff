import 'package:zodostaff/Screens/HomeScreens/Model/HospitalModel.dart';

class ServiceListModel {
  String? id;
  String? name;
  String? description;
  String? image;
  String? price;
  String? strikeThroughPrice;
  String? hospitalId;
  int? dailyBookingCount;
  HospitalModel? hospital;

  ServiceListModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.strikeThroughPrice,
    this.hospitalId,
    this.hospital,
  });

  ServiceListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    dailyBookingCount = json["daily_booking_count"];
    strikeThroughPrice = json['strike_through_price'];
    hospitalId = json['hospital_id'];
    hospital =
        json['hospital'] != null
            ? new HospitalModel.fromJson(json['hospital'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['strike_through_price'] = this.strikeThroughPrice;
    data['hospital_id'] = this.hospitalId;
    if (this.hospital != null) {
      data['hospital'] = this.hospital!.toJson();
    }
    return data;
  }
}

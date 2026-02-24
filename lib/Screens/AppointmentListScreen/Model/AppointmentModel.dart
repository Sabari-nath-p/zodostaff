class AppointmentModel {
  String? id;
  String? bookingId;
  MetaData? metaData;
  String? createdBy;
  String? appointmentDate;
  String? timeSlot;
  String? hospitalId;
  String? doctorId;
  String? hospitalServiceId;
  String? patientNote;
  String? userId;
  String? childUserId;
  UserDetails? userDetails;
  String? status;
  String? type;
  bool? isFastTag;
  String? reason;
  String? amount;
  bool? isOnline;
  int? tokenNumber;
  String? paymentType;
  User? user;

  AppointmentModel({
    this.id,
    this.bookingId,
    this.metaData,
    this.createdBy,
    this.appointmentDate,
    this.timeSlot,
    this.hospitalId,
    this.doctorId,
    this.hospitalServiceId,
    this.patientNote,
    this.userId,
    this.childUserId,
    this.userDetails,
    this.status,
    this.type,
    this.isFastTag,
    this.reason,
    this.amount,
    this.isOnline,
    this.tokenNumber,
    this.paymentType,
    this.user,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    metaData =
        json['meta_data'] != null
            ? new MetaData.fromJson(json['meta_data'])
            : null;
    createdBy = json['created_by'];
    appointmentDate = json['appointmentDate'];
    timeSlot = json['timeSlot'];
    hospitalId = json['hospital_id'];
    doctorId = json['doctor_id'];
    hospitalServiceId = json['hospital_service_id'];
    patientNote = json['patient_note'];
    userId = json['user_id'];
    childUserId = json['child_user_id'];
    userDetails =
        json['user_details'] != null
            ? new UserDetails.fromJson(json['user_details'])
            : null;
    status = json['status'];
    type = json['type'];
    isFastTag = json['is_fast_tag'];
    reason = json['reason'];
    amount = json['amount'];
    isOnline = json['is_online'];
    tokenNumber = json['token_number'];
    paymentType = json['payment_type'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.toJson();
    }
    data['created_by'] = this.createdBy;
    data['appointmentDate'] = this.appointmentDate;
    data['timeSlot'] = this.timeSlot;
    data['hospital_id'] = this.hospitalId;
    data['doctor_id'] = this.doctorId;
    data['hospital_service_id'] = this.hospitalServiceId;
    data['patient_note'] = this.patientNote;
    data['user_id'] = this.userId;
    data['child_user_id'] = this.childUserId;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    data['status'] = this.status;
    data['type'] = this.type;
    data['is_fast_tag'] = this.isFastTag;
    data['reason'] = this.reason;
    data['amount'] = this.amount;
    data['is_online'] = this.isOnline;
    data['token_number'] = this.tokenNumber;
    data['payment_type'] = this.paymentType;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class MetaData {
  int? fee;
  int? total;
  String? currency;
  int? discount;
  String? couponId;
  String? couponCode;
  int? platformFee;

  MetaData({
    this.fee,
    this.total,
    this.currency,
    this.discount,
    this.couponId,
    this.couponCode,
    this.platformFee,
  });

  MetaData.fromJson(Map<String, dynamic> json) {
    fee = json['fee'];
    total = json['total'];
    currency = json['currency'];
    discount = json['discount'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    platformFee = json['platform_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fee'] = this.fee;
    data['total'] = this.total;
    data['currency'] = this.currency;
    data['discount'] = this.discount;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['platform_fee'] = this.platformFee;
    return data;
  }
}

class UserDetails {
  int? age;
  String? name;
  String? gender;

  UserDetails({this.age, this.name, this.gender});

  UserDetails.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    name = json['name'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['name'] = this.name;
    data['gender'] = this.gender;
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? userType;
  String? phone;
  bool? isActive;
  String? districtId;
  String? profilePicture;
  String? createdAt;
  String? updatedAt;
  String? gender;
  int? age;

  User({
    this.id,
    this.firstName,
    this.userType,
    this.phone,
    this.isActive,
    this.districtId,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.age,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    userType = json['user_type'];
    phone = json['phone'];
    isActive = json['is_active'];
    districtId = json['district_id'];
    profilePicture = json['profile_picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    gender = json['gender'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['user_type'] = this.userType;
    data['phone'] = this.phone;
    data['is_active'] = this.isActive;
    data['district_id'] = this.districtId;
    data['profile_picture'] = this.profilePicture;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['gender'] = this.gender;
    data['age'] = this.age;
    return data;
  }
}

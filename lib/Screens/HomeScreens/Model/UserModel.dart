class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? userType;
  String? email;
  String? phone;
  String? password;
  bool? isActive;
  String? hospitalId;
  String? jobTitle;
  String? profilePicture;
  Address? address;
  String? gender;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.userType,
    this.email,
    this.phone,
    this.password,
    this.isActive,
    this.hospitalId,
    this.jobTitle,
    this.profilePicture,
    this.address,
    this.gender,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userType = json['user_type'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    isActive = json['is_active'];
    hospitalId = json['hospital_id'];
    jobTitle = json['job_title'];
    profilePicture = json['profile_picture'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['is_active'] = this.isActive;
    data['hospital_id'] = this.hospitalId;
    data['job_title'] = this.jobTitle;
    data['profile_picture'] = this.profilePicture;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['gender'] = this.gender;
    return data;
  }
}

class Address {
  String? city;
  String? line;
  String? state;
  String? street;
  String? address;
  String? pincode;

  Address({
    this.city,
    this.line,
    this.state,
    this.street,
    this.address,
    this.pincode,
  });

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    line = json['line'];
    state = json['state'];
    street = json['street'];
    address = json['address'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['line'] = this.line;
    data['state'] = this.state;
    data['street'] = this.street;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    return data;
  }
}

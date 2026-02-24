class HospitalModel {
  String? id;
  String? name;
  String? logo;
  String? location;
  Address? address;
  ContactDetails? contactDetails;
  Address? billingAddress;
  String? gst;
  String? website;
  FastTag? fastTag;
  String? status;
  bool? autoBookingEnabled;
  BankDetails? bankDetails;
  String? totalRating;
  String? avgRating;
  int? ratingCount;

  HospitalModel({
    this.id,
    this.name,
    this.logo,
    this.location,
    this.address,
    this.contactDetails,
    this.billingAddress,
    this.gst,
    this.website,
    this.fastTag,
    this.status,
    this.autoBookingEnabled,
    this.bankDetails,
    this.totalRating,
    this.avgRating,
    this.ratingCount,
  });

  HospitalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    location = json['location'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    contactDetails =
        json['contact_details'] != null
            ? new ContactDetails.fromJson(json['contact_details'])
            : null;
    billingAddress =
        json['billing_address'] != null
            ? new Address.fromJson(json['billing_address'])
            : null;
    gst = json['gst'];
    website = json['website'];
    fastTag =
        json['fastTag'] != null ? new FastTag.fromJson(json['fastTag']) : null;
    status = json['status'];
    autoBookingEnabled = json['auto_booking_enabled'];
    bankDetails =
        json['bank_details'] != null
            ? new BankDetails.fromJson(json['bank_details'])
            : null;
    totalRating = json['total_rating'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['location'] = this.location;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.contactDetails != null) {
      data['contact_details'] = this.contactDetails!.toJson();
    }
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    data['gst'] = this.gst;
    data['website'] = this.website;
    if (this.fastTag != null) {
      data['fastTag'] = this.fastTag!.toJson();
    }
    data['status'] = this.status;
    data['auto_booking_enabled'] = this.autoBookingEnabled;
    if (this.bankDetails != null) {
      data['bank_details'] = this.bankDetails!.toJson();
    }
    data['total_rating'] = this.totalRating;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    return data;
  }
}

class Address {
  String? city;
  String? state;
  String? street;
  String? lineOne;
  String? lineTwo;
  String? pincode;
  String? district;

  Address({
    this.city,
    this.state,
    this.street,
    this.lineOne,
    this.lineTwo,
    this.pincode,
    this.district,
  });

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    street = json['street'];
    lineOne = json['lineOne'];
    lineTwo = json['lineTwo'];
    pincode = json['pincode'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['street'] = this.street;
    data['lineOne'] = this.lineOne;
    data['lineTwo'] = this.lineTwo;
    data['pincode'] = this.pincode;
    data['district'] = this.district;
    return data;
  }
}

class ContactDetails {
  String? email;
  String? mobile;
  String? website;

  ContactDetails({this.email, this.mobile, this.website});

  ContactDetails.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobile = json['mobile'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['website'] = this.website;
    return data;
  }
}

class FastTag {
  int? count;
  int? price;
  bool? enabled;

  FastTag({this.count, this.price, this.enabled});

  FastTag.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    price = json['price'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['price'] = this.price;
    data['enabled'] = this.enabled;
    return data;
  }
}

class BankDetails {
  String? ifsc;
  String? upiId;
  String? bankName;
  String? accountHolder;
  String? accountNumber;

  BankDetails({
    this.ifsc,
    this.upiId,
    this.bankName,
    this.accountHolder,
    this.accountNumber,
  });

  BankDetails.fromJson(Map<String, dynamic> json) {
    ifsc = json['ifsc'];
    upiId = json['upi_id'];
    bankName = json['bank_name'];
    accountHolder = json['account_holder'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ifsc'] = this.ifsc;
    data['upi_id'] = this.upiId;
    data['bank_name'] = this.bankName;
    data['account_holder'] = this.accountHolder;
    data['account_number'] = this.accountNumber;
    return data;
  }
}

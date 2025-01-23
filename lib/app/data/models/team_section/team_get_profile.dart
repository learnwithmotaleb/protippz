import 'dart:convert';

class TeamGetProfile {
  bool? success;
  String? message;
  TeamGetProfileData? data;

  TeamGetProfile({
    this.success,
    this.message,
    this.data,
  });

  factory TeamGetProfile.fromRawJson(String str) => TeamGetProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeamGetProfile.fromJson(Map<String, dynamic> json) => TeamGetProfile(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : TeamGetProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class TeamGetProfileData {
  String? id;
  String? name;
  String? teamLogo;
  String? league;
  String? teamBgImage;
  String? sport;
  int? totalTips;
  int? paidAmount;
  int? dueAmount;
  bool? isStripeConnected;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  User? user;
  String? stripAccountId;
  Address? address;
  TaxInfo? taxInfo;

  TeamGetProfileData({
    this.id,
    this.name,
    this.teamLogo,
    this.league,
    this.teamBgImage,
    this.sport,
    this.totalTips,
    this.paidAmount,
    this.dueAmount,
    this.isStripeConnected,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.user,
    this.stripAccountId,
    this.address,
    this.taxInfo,
  });

  factory TeamGetProfileData.fromRawJson(String str) => TeamGetProfileData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeamGetProfileData.fromJson(Map<String, dynamic> json) => TeamGetProfileData(
    id: json["_id"],
    name: json["name"],
    teamLogo: json["team_logo"],
    league: json["league"],
    teamBgImage: json["team_bg_image"],
    sport: json["sport"],
    totalTips: json["totalTips"],
    paidAmount: json["paidAmount"],
    dueAmount: json["dueAmount"],
    isStripeConnected: json["isStripeConnected"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    stripAccountId: json["stripAccountId"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    taxInfo: json["taxInfo"] == null ? null : TaxInfo.fromJson(json["taxInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "team_logo": teamLogo,
    "league": league,
    "team_bg_image": teamBgImage,
    "sport": sport,
    "totalTips": totalTips,
    "paidAmount": paidAmount,
    "dueAmount": dueAmount,
    "isStripeConnected": isStripeConnected,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "user": user?.toJson(),
    "stripAccountId": stripAccountId,
    "address": address?.toJson(),
    "taxInfo": taxInfo?.toJson(),
  };
}

class Address {
  String? city;
  String? state;
  String? streetAddress;
  int? zipCode;
  String? id;

  Address({
    this.city,
    this.state,
    this.streetAddress,
    this.zipCode,
    this.id,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json["city"],
    state: json["state"],
    streetAddress: json["streetAddress"],
    zipCode: json["zipCode"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "state": state,
    "streetAddress": streetAddress,
    "zipCode": zipCode,
    "_id": id,
  };
}

class TaxInfo {
  String? address;
  String? fullname;
  String? taxId;
  String? id;

  TaxInfo({
    this.address,
    this.fullname,
    this.taxId,
    this.id,
  });

  factory TaxInfo.fromRawJson(String str) => TaxInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxInfo.fromJson(Map<String, dynamic> json) => TaxInfo(
    address: json["address"],
    fullname: json["fullname"],
    taxId: json["taxId"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "fullname": fullname,
    "taxId": taxId,
    "_id": id,
  };
}

class User {
  String? role;

  User({
    this.role,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
  };
}

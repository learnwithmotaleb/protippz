import 'dart:convert';

class PlayerGetProfile {
  bool? success;
  String? message;
  PlayerGetProfileData? data;

  PlayerGetProfile({
    this.success,
    this.message,
    this.data,
  });

  factory PlayerGetProfile.fromRawJson(String str) => PlayerGetProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerGetProfile.fromJson(Map<String, dynamic> json) => PlayerGetProfile(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : PlayerGetProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class PlayerGetProfileData {
  String? id;
  String? name;
  String? league;
  Team? team;
  String? position;
  String? playerImage;
  String? playerBgImage;
  int? totalTips;
  int? paidAmount;
  int? dueAmount;
  bool? isStripeConnected;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? invitedPassword;
  User? user;
  String? username;
  Address? address;
  TaxInfo? taxInfo;

  PlayerGetProfileData({
    this.id,
    this.name,
    this.league,
    this.team,
    this.position,
    this.playerImage,
    this.playerBgImage,
    this.totalTips,
    this.paidAmount,
    this.dueAmount,
    this.isStripeConnected,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.invitedPassword,
    this.user,
    this.username,
    this.address,
    this.taxInfo,
  });

  factory PlayerGetProfileData.fromRawJson(String str) => PlayerGetProfileData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerGetProfileData.fromJson(Map<String, dynamic> json) => PlayerGetProfileData(
    id: json["_id"],
    name: json["name"],
    league: json["league"],
    team: json["team"] == null ? null : Team.fromJson(json["team"]),
    position: json["position"],
    playerImage: json["player_image"],
    playerBgImage: json["player_bg_image"],
    totalTips: json["totalTips"],
    paidAmount: json["paidAmount"],
    dueAmount: json["dueAmount"],
    isStripeConnected: json["isStripeConnected"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    invitedPassword: json["invitedPassword"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    username: json["username"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    taxInfo: json["taxInfo"] == null ? null : TaxInfo.fromJson(json["taxInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "league": league,
    "team": team?.toJson(),
    "position": position,
    "player_image": playerImage,
    "player_bg_image": playerBgImage,
    "totalTips": totalTips,
    "paidAmount": paidAmount,
    "dueAmount": dueAmount,
    "isStripeConnected": isStripeConnected,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "invitedPassword": invitedPassword,
    "user": user?.toJson(),
    "username": username,
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

class Team {
  String? id;
  String? name;

  Team({
    this.id,
    this.name,
  });

  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
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

import 'dart:convert';

class PlayerTippzModel {
  bool? success;
  String? message;
  PlayerTippzData? data;

  PlayerTippzModel({
    this.success,
    this.message,
    this.data,
  });

  factory PlayerTippzModel.fromRawJson(String str) => PlayerTippzModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerTippzModel.fromJson(Map<String, dynamic> json) => PlayerTippzModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : PlayerTippzData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class PlayerTippzData {
  Meta? meta;
  List<Result>? result;

  PlayerTippzData({
    this.meta,
    this.result,
  });

  factory PlayerTippzData.fromRawJson(String str) => PlayerTippzData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerTippzData.fromJson(Map<String, dynamic> json) => PlayerTippzData(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}

class Result {
  String? id;
  User? user;
  String? entityId;
  String? entityType;
  int? point;
  int? amount;
  String? paymentStatus;
  String? tipBy;
  String? transactionId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Result({
    this.id,
    this.user,
    this.entityId,
    this.entityType,
    this.point,
    this.amount,
    this.paymentStatus,
    this.tipBy,
    this.transactionId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    entityId: json["entityId"],
    entityType: json["entityType"],
    point: json["point"],
    amount: json["amount"],
    paymentStatus: json["paymentStatus"],
    tipBy: json["tipBy"],
    transactionId: json["transactionId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "entityId": entityId,
    "entityType": entityType,
    "point": point,
    "amount": amount,
    "paymentStatus": paymentStatus,
    "tipBy": tipBy,
    "transactionId": transactionId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class User {
  String? id;
  String? name;
  String? profileImage;

  User({
    this.id,
    this.name,
    this.profileImage,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "profile_image": profileImage,
  };
}

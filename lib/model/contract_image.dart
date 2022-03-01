import 'dart:convert';

class ContractImageList {
  ContractImageList({
    required this.message,
    required this.data,
    required this.code,
  });

  String message;
  List<ContractImage> data;
  int code;

  factory ContractImageList.fromJson(String str) => ContractImageList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContractImageList.fromMap(Map<String, dynamic> json) => ContractImageList(
    message: json["message"],
    data: List<ContractImage>.from(json["data"].map((x) => ContractImage.fromMap(x))),
    code: json["code"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "code": code,
  };
}

class ContractImage {
  ContractImage({
    required this.id,
    required this.contractId,
    required this.mediaUrl,
    required this.typeId,
    required this.createdAt,
    required this.status,
    required this.imageType,
  });

  int? id;
  int? contractId;
  String? mediaUrl;
  int? typeId;
  String? createdAt;
  int? status;
  String? imageType;

  factory ContractImage.fromJson(String str) => ContractImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContractImage.fromMap(Map<String, dynamic> json) => ContractImage(
    id: json["id"],
    contractId: json["contract_id"],
    mediaUrl: json["media_url"],
    typeId: json["type_id"],
    createdAt: json["created_at"],
    status: json["status"]??-1,
    imageType: json["imageType"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "contract_id": contractId,
    "media_url": mediaUrl,
    "type_id": typeId,
    "created_at": createdAt,
    "status": status,
    "imageType": imageType,
  };
}

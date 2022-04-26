// To parse this JSON data, do
//
//     final history = historyFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class History {
  History({
    required this.id,
    required this.clientPhone,
    required this.carPlate,
    required this.contractNumber,
    required this.deliveredId,
    required this.receiverId,
    required this.companyId,
    required this.clientName,
    required this.deliverDate,
    required this.reciveDate,
    required this.delivered,
    required this.receiver,
    required this.company,
    required this.deliveredImages,
    required this.recivedImages,
  });

  int id;
  String clientPhone;
  String carPlate;
  String contractNumber;
  int deliveredId;
  int receiverId;
  int companyId;
  dynamic clientName;
  DateTime deliverDate;
  String reciveDate;
  String delivered;
  String receiver;
  String company;
  List<EdImage> deliveredImages;
  List<EdImage> recivedImages;

  factory History.fromJson(String str) => History.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory History.fromMap(Map<String, dynamic> json) => History(
    id: json["id"] ?? -1,
    clientPhone: json["client_phone"] ?? "",
    carPlate: json["car_plate"] ?? "",
    contractNumber: json["contract_number"] ?? "",
    deliveredId: json["delivered_id"] ?? -1,
    receiverId: json["receiver_id"] ?? -1,
    companyId: json["company_id"] ?? -1,
    clientName: json["client_name"] ?? "",
    deliverDate: DateTime.parse(json["deliver_date"]),
    reciveDate: json["recive_date"] ?? "",
    delivered: json["delivered"] ?? "",
    receiver: json["receiver"] ?? "",
    company: json["company"] ?? "",
    deliveredImages: List<EdImage>.from(json["delivered_images"].map((x) => EdImage.fromMap(x))),
    recivedImages: List<EdImage>.from(json["recived_images"].map((x) => EdImage.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "client_phone": clientPhone,
    "car_plate": carPlate,
    "contract_number": contractNumber,
    "delivered_id": deliveredId,
    "receiver_id": receiverId == null ? null : receiverId,
    "company_id": companyId,
    "client_name": clientName,
    "deliver_date": deliverDate.toIso8601String(),
    "recive_date": reciveDate,
    "delivered": delivered,
    "receiver": receiver == null ? null : receiver,
    "company": company,
    "delivered_images": List<dynamic>.from(deliveredImages.map((x) => x.toMap())),
    "recived_images": List<dynamic>.from(recivedImages.map((x) => x.toMap())),
  };
}

class EdImage {
  EdImage({
    required this.id,
    required this.link,
    required this.mediaTypeId,
    required this.contractId,
    required this.state,
    required this.type,
  });

  int id;
  String link;
  int mediaTypeId;
  int contractId;
  int state;
  String type;

  factory EdImage.fromJson(String str) => EdImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EdImage.fromMap(Map<String, dynamic> json) => EdImage(
    id: json["id"],
    link: json["link"],
    mediaTypeId: json["media_type_id"],
    contractId: json["contract_id"],
    state: json["state"],
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "link": link,
    "media_type_id": mediaTypeId,
    "contract_id": contractId,
    "state": state,
    "type": type,
  };
}

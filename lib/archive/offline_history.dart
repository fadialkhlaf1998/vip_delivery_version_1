import 'dart:convert';

class OfflineHistory {
  OfflineHistory({
    required this.id,
    required this.clientName,
    required this.clientPhone,
    required this.contractNumber,
    required this.carPlate,
    required this.deliveredId,
    required this.delivered,
    required this.receiverId,
    required this.receiver,
    required this.statusId,
    required this.status,
    required this.deliverDate,
    required this.receiveDate,
    required this.media,
    required this.mediaTypeId,
  });
  int id;
  String clientName;
  String clientPhone;
  String contractNumber;
  String carPlate;
  int deliveredId;
  String delivered;
  int receiverId;
  String receiver;
  int statusId;
  String status;
  String deliverDate;
  String receiveDate;
  List<dynamic> media;
  List<dynamic> mediaTypeId;


  factory OfflineHistory.fromJson(String str) => OfflineHistory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfflineHistory.fromMap(Map<String, dynamic> json) => OfflineHistory(
    id: json["id"],
    clientName: json["client_name"]==null?"":json["client_name"],
    clientPhone: json["client_phone"],
    contractNumber: json["contract_number"],
    carPlate: json["car_plate"],
    deliveredId: json["delivered_id"],
    delivered: json["delivered"],
    receiverId: json["receiver_id"],
    receiver: json["receiver"],
    statusId: json["status_id"],
    status: json["status"],
    deliverDate: json["deliver_date"],
    receiveDate: json["receive_date"],
    media: json["media"],
    mediaTypeId: json["mediaTypeId"],
  );

  Map<String, dynamic> toMap() => {
    "id":id,
    "client_name": clientName,
    "client_phone": clientPhone,
    "contract_number": contractNumber,
    "car_plate": carPlate,
    "delivered_id": deliveredId,
    "delivered": delivered,
    "receiver_id": receiverId,
    "receiver": receiver,
    "status_id": statusId,
    "status": status,
    "deliver_date": deliverDate,
    "receive_date": receiveDate,
    "media" : media,
    "mediaTypeId":mediaTypeId
  };
}
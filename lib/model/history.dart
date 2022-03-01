import 'dart:convert';

class HistoryList {
  HistoryList({
    required this.message,
    required this.data,
    required this.code,
  });

  String message;
  List<History> data;
  int code;

  factory HistoryList.fromJson(String str) => HistoryList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryList.fromMap(Map<String, dynamic> json) => HistoryList(
    message: json["message"],
    data: List<History>.from(json["data"].map((x) => History.fromMap(x))),
    code: json["code"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "code": code,
  };
}

class History {
  History({
    required this.id,
    required this.clientName,
    required  this.clientPhone,
    required this.contractNumber,
    required this.carPlate,
    required this.deliveredId,
    required this.delivered,
    required this.receiverId,
    required this.receiver,
    required  this.statusId,
    required this.status,
    required this.deliverDate,
    required this.receiveDate,
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

  factory History.fromJson(String str) => History.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory History.fromMap(Map<String, dynamic> json) => History(
    id: json["id"]==null?-1:json["id"],
    clientName: json["client_name"]==null?"":json["client_name"],
    clientPhone: json["client_phone"]==null?"":json["client_phone"],
    contractNumber: json["contract_number"]==null?"":json["contract_number"],
    carPlate: json["car_plate"]==null?"":json["car_plate"],
    deliveredId: json["delivered_id"]==null?-1:json["delivered_id"],
    delivered: json["delivered"]==null?"":json["delivered"],
    receiverId: json["receiver_id"]==null?-1:json["receiver_id"],
    receiver: json["receiver"]==null?"":json["receiver"],
    statusId: json["status_id"]==null?-1:json["status_id"],
    status: json["status"]==null?"":json["status"],
    deliverDate: json["deliver_date"]==null?"":json["deliver_date"],
    receiveDate: json["receive_date"]==null?"":json["receive_date"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
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
  };
}


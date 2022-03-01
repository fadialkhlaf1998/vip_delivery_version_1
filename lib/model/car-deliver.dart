import 'dart:convert';

class CarDeliver {
  CarDeliver({
    required this.message,
    required this.data,
    required this.code,
  });

  String message;
  dynamic data;
  int code;

  factory CarDeliver.fromJson(String str) => CarDeliver.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarDeliver.fromMap(Map<String, dynamic> json) => CarDeliver(
    message: json["message"],
    data: json["data"],
    code: json["code"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": data,
    "code": code,
  };
}

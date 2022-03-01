import 'dart:convert';

class ChauffeursList {
  ChauffeursList({
    required this.message,
    required this.data,
    required this.code,
  });

  String message;
  List<Chauffeur> data;
  int code;

  factory ChauffeursList.fromJson(String str) => ChauffeursList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChauffeursList.fromMap(Map<String, dynamic> json) => ChauffeursList(
    message: json["message"],
    data: List<Chauffeur>.from(json["data"].map((x) => Chauffeur.fromMap(x))),
    code: json["code"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "code": code,
  };
}

class Chauffeur {
  Chauffeur({
    required this.id,
    required this.name,
    required this.pinCode,
    required this.isActive,
    required this.createdAt,
  });

  int id;
  String name;
  String pinCode;
  int isActive;
  String createdAt;

  factory Chauffeur.fromJson(String str) => Chauffeur.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Chauffeur.fromMap(Map<String, dynamic> json) => Chauffeur(
    id: json["id"],
    name: json["name"],
    pinCode: json["pin_code"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "pin_code": pinCode,
    "is_active": isActive,
    "created_at": createdAt,
  };
}

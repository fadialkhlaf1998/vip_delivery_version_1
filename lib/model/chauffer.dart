// To parse this JSON data, do
//
//     final chauffeur = chauffeurFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';


class Chauffeur {
  Chauffeur({
    required this.id,
    required this.title,
    required this.pin,
    required this.companyId,
    required this.company,
  });

  int id;
  String title;
  String pin;
  int companyId;
  String company;

  factory Chauffeur.fromJson(String str) => Chauffeur.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Chauffeur.fromMap(Map<String, dynamic> json) => Chauffeur(
    id: json["id"],
    title: json["title"],
    pin: json["pin"],
    companyId: json["company_id"],
    company: json["company"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "pin": pin,
    "company_id": companyId,
    "company": company,
  };
}

// To parse this JSON data, do
//
//     final historyList = historyListFromMap(jsonString);

import 'dart:convert';

class Media {
  Media({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Media.fromJson(String str) => Media.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Media.fromMap(Map<String, dynamic> json) => Media(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
  };
}

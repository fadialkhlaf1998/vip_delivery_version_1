// To parse this JSON data, do
//
//     final historyList = historyListFromMap(jsonString);

import 'dart:convert';

class MediaTypeList {
  MediaTypeList({
    required this.message,
    required this.data,
    required this.code,
  });

  String message;
  List<Media> data;
  int code;

  factory MediaTypeList.fromJson(String str) => MediaTypeList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MediaTypeList.fromMap(Map<String, dynamic> json) => MediaTypeList(
    message: json["message"],
    data: List<Media>.from(json["data"].map((x) => Media.fromMap(x))),
    code: json["code"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "code": code,
  };
}

class Media {
  Media({
    required this.id,
    required this.title,
    required this.createdAt,
    // this.updatedAt,
  });

  int id;
  String title;
  String createdAt;

  factory Media.fromJson(String str) => Media.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Media.fromMap(Map<String, dynamic> json) => Media(
    id: json["id"],
    title: json["title"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "created_at": createdAt,
  };
}

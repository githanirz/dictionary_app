// To parse this JSON data, do
//
//     final modelDictionary = modelDictionaryFromJson(jsonString);

import 'dart:convert';

ModelDictionary modelDictionaryFromJson(String str) =>
    ModelDictionary.fromJson(json.decode(str));

String modelDictionaryToJson(ModelDictionary data) =>
    json.encode(data.toJson());

class ModelDictionary {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelDictionary({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelDictionary.fromJson(Map<String, dynamic> json) =>
      ModelDictionary(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String kataIndo;
  String kataBelanda;
  String deskripsi;

  Datum({
    required this.id,
    required this.kataIndo,
    required this.kataBelanda,
    required this.deskripsi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        kataIndo: json["kata_indo"],
        kataBelanda: json["kata_belanda"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kata_indo": kataIndo,
        "kata_belanda": kataBelanda,
        "deskripsi": deskripsi,
      };
}

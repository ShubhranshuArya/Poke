// To parse this JSON data, do
//
//     final pokeStoryModel = pokeStoryModelFromJson(jsonString);

import 'dart:convert';

List<PokeDexApiDetailModel> pokeDexApiDetailModelFromJson(String str) =>
    List<PokeDexApiDetailModel>.from(
        json.decode(str).map((x) => PokeDexApiDetailModel.fromJson(x)));

class PokeDexApiDetailModel {
  PokeDexApiDetailModel({
    // this.starter,
    // this.legendary,
    // this.mythical,
    // this.ultraBeast,
    // this.mega,
    // this.gen,
    this.description,
  });

  // bool? starter;
  // bool? legendary;
  // bool? mythical;
  // bool? ultraBeast;
  // bool? mega;
  // int? gen;
  String? description;

  factory PokeDexApiDetailModel.fromJson(Map<String, dynamic> json) =>
      PokeDexApiDetailModel(
        // starter: json["starter"],
        // legendary: json["legendary"],
        // mythical: json["mythical"],
        // ultraBeast: json["ultraBeast"],
        // mega: json["mega"],
        // gen: json["gen"],
        description: json["description"],
      );
}

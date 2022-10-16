import 'dart:convert';

import '../../../constants/strings.dart';

PokeStoryModel pokeStoryModelFromJson(String str) =>
    PokeStoryModel.fromJson(json.decode(str));

class PokeStoryModel {
  PokeStoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
  });
  int id;
  String name;
  String imageUrl;
  List<Type> types;

  factory PokeStoryModel.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final imageUrl = "$containerImageUrl$id.png";
    return PokeStoryModel(
      id: id,
      name: json["name"],
      imageUrl: imageUrl,
      types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
    );
  }
}

class Species {
  Species({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
      );
}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  int slot;
  Species type;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromJson(json["type"]),
      );
}

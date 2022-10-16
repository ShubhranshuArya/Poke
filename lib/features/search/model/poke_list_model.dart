// To parse this JSON data, do
//
//     final pokeListModel = pokeListModelFromJson(jsonString);

import 'dart:convert';

import 'package:poke_app/constants/strings.dart';

PokeListModel pokeListModelFromJson(String str) =>
    PokeListModel.fromJson(json.decode(str));

String pokeListModelToJson(PokeListModel data) => json.encode(data.toJson());

class PokeListModel {
  PokeListModel({
    this.next,
    this.previous,
    required this.results,
  });

  String? next;
  String? previous;
  List<PokeContainerModel>? results;

  factory PokeListModel.fromJson(Map<String, dynamic> json) => PokeListModel(
        next: json["next"],
        previous: json["previous"],
        results: List<PokeContainerModel>.from(
            json["results"].map((x) => PokeContainerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class PokeContainerModel {
  PokeContainerModel({
    required this.name,
    required this.url,
    required this.id,
    required this.imageUrl,
  });

  String name;
  String url;
  int id;
  String imageUrl;

  factory PokeContainerModel.fromJson(Map<String, dynamic> json) {
    final url = json["url"] as String;
    final id = int.parse(url.split('/')[6]);
    final imageUrl = "$containerImageUrl$id.png";
    return PokeContainerModel(
      name: json["name"],
      url: json["url"],
      id: id,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

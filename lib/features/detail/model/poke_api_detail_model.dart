// To parse required this JSON data, do
//
//     final pokeDetailModel = pokeDetailModelFromJson(jsonString);

import 'dart:convert';

PokeApiDetailModel pokeDetailModelFromJson(String str) =>
    PokeApiDetailModel.fromJson(json.decode(str));

class PokeApiDetailModel {
  PokeApiDetailModel({
    required this.abilities,
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.name,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  List<Ability> abilities;
  int? baseExperience;
  int? height;
  int? id;
  String? name;
  Species? species;
  Sprites? sprites;
  List<Stat>? stats;
  List<Type>? types;
  int? weight;

  factory PokeApiDetailModel.fromJson(Map<String, dynamic> json) =>
      PokeApiDetailModel(
        abilities: List<Ability>.from(
            json["abilities"].map((x) => Ability.fromJson(x))),
        baseExperience: json["base_experience"],
        height: json["height"],
        id: json["id"],
        name: json["name"],
        species: Species.fromJson(json["species"]),
        sprites: Sprites.fromJson(json["sprites"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        weight: json["weight"],
      );
}

class Ability {
  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  Species? ability;
  bool? isHidden;
  int? slot;

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        ability: Species.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );
}

class Species {
  Species({
    required this.name,
    required this.url,
  });

  String? name;
  String? url;

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
      );
}

class Sprites {
  Sprites({
    required this.other,
    required this.versions,
  });

  Other? other;
  Versions? versions;

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        other: Other.fromJson(json["other"]),
        versions: Versions.fromJson(json["versions"]),
      );
}

class Other {
  Other({
    required this.dreamWorld,
    required this.home,
    required this.officialArtwork,
  });

  DreamWorld? dreamWorld;
  Home? home;
  OfficialArtwork? officialArtwork;

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        dreamWorld: DreamWorld.fromJson(json["dream_world"]),
        home: Home.fromJson(json["home"]),
        officialArtwork: OfficialArtwork.fromJson(json["official-artwork"]),
      );
}

class DreamWorld {
  DreamWorld({
    required this.frontDefault,
  });

  String? frontDefault;

  factory DreamWorld.fromJson(Map<String, dynamic> json) => DreamWorld(
        frontDefault: json["front_default"],
      );
}

class Home {
  Home({
    required this.frontDefault,
    required this.frontShiny,
  });

  String? frontDefault;
  String? frontShiny;

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        frontDefault: json["front_default"],
        frontShiny: json["front_shiny"],
      );
}

class OfficialArtwork {
  OfficialArtwork({
    required this.frontDefault,
  });

  String? frontDefault;

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      OfficialArtwork(
        frontDefault: json["front_default"],
      );
}

class Versions {
  Versions({
    required this.generationI,
    required this.generationIi,
    required this.generationIii,
    required this.generationIv,
    required this.generationV,
    required this.generationVi,
    required this.generationVii,
    required this.generationViii,
  });

  GenerationI? generationI;
  GenerationIi? generationIi;
  GenerationIii? generationIii;
  GenerationIv? generationIv;
  GenerationV? generationV;
  GenerationVi? generationVi;
  GenerationVii? generationVii;
  GenerationViii? generationViii;

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
        generationI: GenerationI.fromJson(json["generation-i"]),
        generationIi: GenerationIi.fromJson(json["generation-ii"]),
        generationIii: GenerationIii.fromJson(json["generation-iii"]),
        generationIv: GenerationIv.fromJson(json["generation-iv"]),
        generationV: GenerationV.fromJson(json["generation-v"]),
        generationVi: GenerationVi.fromJson(json["generation-vi"]),
        generationVii: GenerationVii.fromJson(json["generation-vii"]),
        generationViii: GenerationViii.fromJson(json["generation-viii"]),
      );
}

class CustomFrontDefault {
  CustomFrontDefault({
    required this.frontDefault,
  });

  String? frontDefault;

  factory CustomFrontDefault.fromJson(Map<String, dynamic> json) =>
      CustomFrontDefault(
        frontDefault: json["front_default"],
      );
}

class GenerationI {
  GenerationI({
    required this.redBlue,
    required this.yellow,
  });

  CustomFrontDefault? redBlue;
  CustomFrontDefault? yellow;

  factory GenerationI.fromJson(Map<String, dynamic> json) => GenerationI(
        redBlue: CustomFrontDefault.fromJson(json["red-blue"]),
        yellow: CustomFrontDefault.fromJson(json["yellow"]),
      );
}

class GenerationIi {
  GenerationIi({
    required this.crystal,
    required this.gold,
    required this.silver,
  });

  CustomFrontDefault? crystal;
  CustomFrontDefault? gold;
  CustomFrontDefault? silver;

  factory GenerationIi.fromJson(Map<String, dynamic> json) => GenerationIi(
        crystal: CustomFrontDefault.fromJson(json["crystal"]),
        gold: CustomFrontDefault.fromJson(json["gold"]),
        silver: CustomFrontDefault.fromJson(json["silver"]),
      );
}

class GenerationIii {
  GenerationIii({
    required this.emerald,
    required this.fireredLeafgreen,
    required this.rubySapphire,
  });

  CustomFrontDefault? emerald;
  CustomFrontDefault? fireredLeafgreen;
  CustomFrontDefault? rubySapphire;

  factory GenerationIii.fromJson(Map<String, dynamic> json) => GenerationIii(
        emerald: CustomFrontDefault.fromJson(json["emerald"]),
        fireredLeafgreen:
            CustomFrontDefault.fromJson(json["firered-leafgreen"]),
        rubySapphire: CustomFrontDefault.fromJson(json["ruby-sapphire"]),
      );
}

class GenerationIv {
  GenerationIv({
    required this.diamondPearl,
    required this.heartgoldSoulsilver,
    required this.platinum,
  });

  CustomFrontDefault? diamondPearl;
  CustomFrontDefault? heartgoldSoulsilver;
  CustomFrontDefault? platinum;

  factory GenerationIv.fromJson(Map<String, dynamic> json) => GenerationIv(
        diamondPearl: CustomFrontDefault.fromJson(json["diamond-pearl"]),
        heartgoldSoulsilver:
            CustomFrontDefault.fromJson(json["heartgold-soulsilver"]),
        platinum: CustomFrontDefault.fromJson(json["platinum"]),
      );
}

class GenerationV {
  GenerationV({
    required this.blackWhite,
  });

  CustomFrontDefault? blackWhite;

  factory GenerationV.fromJson(Map<String, dynamic> json) => GenerationV(
        blackWhite: CustomFrontDefault.fromJson(json["black-white"]),
      );
}

class GenerationVi {
  GenerationVi({
    required this.omega,
    required this.xy,
  });

  CustomFrontDefault? omega;
  CustomFrontDefault? xy;

  factory GenerationVi.fromJson(Map<String, dynamic> json) => GenerationVi(
        omega: CustomFrontDefault.fromJson(json["omegaruby-alphasapphire"]),
        xy: CustomFrontDefault.fromJson(json["x-y"]),
      );
}

class GenerationVii {
  GenerationVii({
    required this.icons,
    required this.ultraSunUltraMoon,
  });

  CustomFrontDefault? icons;
  CustomFrontDefault? ultraSunUltraMoon;

  factory GenerationVii.fromJson(Map<String, dynamic> json) => GenerationVii(
        icons: CustomFrontDefault.fromJson(json["icons"]),
        ultraSunUltraMoon:
            CustomFrontDefault.fromJson(json["ultra-sun-ultra-moon"]),
      );
}

class GenerationViii {
  GenerationViii({
    required this.icons,
  });

  CustomFrontDefault? icons;

  factory GenerationViii.fromJson(Map<String, dynamic> json) => GenerationViii(
        icons: CustomFrontDefault.fromJson(json["icons"]),
      );
}

class Stat {
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  int? baseStat;
  int? effort;
  Species? stat;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Species.fromJson(json["stat"]),
      );
}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  int? slot;
  Species? type;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromJson(json["type"]),
      );
}

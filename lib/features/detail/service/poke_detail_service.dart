import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/constants/strings.dart';
import 'package:poke_app/features/detail/model/poke_api_detail_model.dart';
import 'package:poke_app/features/detail/model/poke_dex_api_detail_model.dart';

class PokeDetailService {
  Future<PokeApiDetailModel?> getDetailFromPokeApi(int id) async {
    try {
      var client = http.Client();
      var url = Uri.parse("$pokeApiDetailUrl$id/");
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return pokeDetailModelFromJson(jsonString);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<List<PokeDexApiDetailModel>?> getDetailFromPokeDexApi(int id) async {
    try {
      var client = http.Client();
      var url = Uri.parse("$pokeDexDetailUrl/$id");
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return pokeDexApiDetailModelFromJson(jsonString);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}

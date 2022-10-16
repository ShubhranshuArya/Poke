import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/constants/strings.dart';
import 'package:poke_app/features/detail/model/poke_api_detail_model.dart';
import 'package:poke_app/features/search/model/poke_list_model.dart';

class PokeSearchService {
  Future<PokeListModel?> getPokeContainerList() async {
    try {
      var client = http.Client();
      var url = Uri.parse(pokeApiListUrl);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return pokeListModelFromJson(jsonString);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<PokeApiDetailModel?> searchPokeByNameId({
    required String searchedText,
  }) async {
    try {
      var value = searchedText[0].toLowerCase() + searchedText.substring(1);
      var client = http.Client();
      var url = Uri.parse("$pokeApiDetailUrl$value/");
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
}

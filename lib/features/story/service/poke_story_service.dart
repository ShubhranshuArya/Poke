import 'package:flutter/material.dart';

import '../../../constants/strings.dart';
import '../model/poke_story_model.dart';
import 'package:http/http.dart' as http;

class PokeStoryService {
  Future<PokeStoryModel?> getPokeStory(int id) async {
    try {
      var client = http.Client();
      var url = Uri.parse("$pokeApiDetailUrl$id/");
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return pokeStoryModelFromJson(jsonString);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}

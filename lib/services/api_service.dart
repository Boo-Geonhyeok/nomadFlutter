import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nomadflutter/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToon() async {
    List<WebtoonModel> webtoons = [];
    final url = Uri.parse("$baseUrl/today");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoonsJson = jsonDecode(response.body);

      for (var webtoon in webtoonsJson) {
        webtoons.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoons;
    }
    throw Error();
  }

  static Future<DetailModel> getDetail(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final detail = jsonDecode(response.body);
      return DetailModel.fromJson(detail);
    } else {
      throw Error();
    }
  }

  static Future<List<EpisodeModel>> getEpisodes(String id) async {
    List<EpisodeModel> episodes = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodesJson = jsonDecode(response.body);
      for (var e in episodesJson) {
        episodes.add(EpisodeModel.fromJson(e));
      }
      return episodes;
    }
    throw Error();
  }
}

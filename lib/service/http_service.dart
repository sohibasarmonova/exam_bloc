import 'dart:convert';
import 'package:exam_news/models/post_news_model.dart';
import 'package:http/http.dart';

class Network {
  static String BASE = "newsapi.org";

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Apis*/
  static String API_GET_NEWS = "/v2/everything";

  /* Http Params */

  static Map<String, String> paramsArticle() {
    Map<String, String> params = {};
    params.addAll({
      'q': "tesla",
      'sortBy': 'publishedAt',
      'apiKey': 'eb1ec43e218649538cc445c8eb59df7c'
    });
    return params;
  }

  /* Http Parsing */

  static List<Article> parseArticles(String response) {
    dynamic json = jsonDecode(response);
    return ArticlesList.fromJson(json).articles;
  }
}
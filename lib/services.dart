import 'dart:convert';
import 'dart:io';

import 'package:flutter_news_app/constants/api_key.dart';
import 'package:flutter_news_app/screens/model/article_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  String baseUrl = 'https://newsapi.org/v2/';
  String apiKey = key;
  Future<List<Article>> getData(String customurl) async {
    try {
      var url = Uri.parse('$baseUrl' + '$customurl' + '&apiKey=$key');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);

        List<dynamic> body = json['articles'];

        List<Article> articles =
            body.map((dynamic item) => Article.fromJson(item)).toList();
        return articles;
      } else {
        throw ("Can't get the Articles");
      }
    } on SocketException {
      throw Error(message: 'No Internet Connection😐😐');
    }
  }
}

class Error {
  String message;
  Error({required this.message});

  @override
  String toString() => message;
}

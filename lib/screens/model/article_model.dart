import 'package:flutter_news_app/screens/model/source_model.dart';
import 'package:intl/intl.dart';

class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  Article({
    this.source,
    this.author,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.title,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] == null ? "No author" : json["author"],
      title: json['title'] == null ? "No title" : json['title'],
      description: json['description'] == null ? "No description" : json["description"],
      url: json['url'] == null ? "" : json['url'],
      urlToImage: json['urlToImage'] == null ? "null" : json["urlToImage"],
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'] == null ? "" : json['content'],
    );
  }
  late String formattedDate = DateFormat.yMMMd().format(publishedAt!);
}

import 'dart:convert';
class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImg;
  // Add more properties as needed

  Article( {
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImg,
    // Add more parameters here
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImg: json['urlToImage'] ?? '',
      // Parse and add more properties as needed
    );
  }
}
  import 'dart:convert';

  import 'package:http/http.dart' as http;
  import 'package:test_news_project/models/newsArticle.dart';

  class NewsRepo {
    final String baseUrl =
        'https://newsapi.org/v2/everything?q=apple&from=2025-04-23&to=2025-04-23&sortBy=popularity&apiKey=7794cd7e577b4047a0e3d0a41fa86987';

    Future<List<NewsArticle>> getNews() async {
      try {
        final response = await http.get(Uri.parse('$baseUrl'));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          final articlesJson = data['articles'] as List;


          return articlesJson.map((json) {
            final source = json['source'] ?? {};
            return NewsArticle(
              id: source['id'] ?? '',
              name: source['name'] ?? '',
              author: json['author'] ?? 'Unknown',
              title: json['title'] ?? '',
              description: json['description'] ?? '',
              url: json['url'] ?? '',
              urlToImage: json['urlToImage'] ?? '',
              publishedAt: DateTime.parse(json['publishedAt']),
              content: json['content'] ?? '',
            );
          }).toList();
        } else {
  throw Exception(response.body);      }
      } catch (e) {
        throw Exception('Server error : $e');
      }
    }
  }

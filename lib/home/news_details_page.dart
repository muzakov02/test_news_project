import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_news_project/models/newsArticle.dart';

class NewsDetailsPage extends StatefulWidget {
  final NewsArticle newsArticle;

  const NewsDetailsPage({Key? key, required this.newsArticle}) : super(key: key);

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // widget.newsArticle orqali uzatilgan newsArticle ga murojaat qilamiz
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(widget.newsArticle.urlToImage),
            ),
            Text(widget.newsArticle.name, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(widget.newsArticle.title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(DateFormat.yMMMMd().format(widget.newsArticle.publishedAt), style: TextStyle(color: Colors.grey)),
            SizedBox(height: 12),
            Text(widget.newsArticle.content),
          ],
        ),
      ),
    );
  }
}

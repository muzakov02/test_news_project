import 'package:test_news_project/models/newsArticle.dart';

abstract class NewsState{
  const NewsState();
}

class NewsInit extends NewsState {
  const NewsInit();
}

class NewsLoading extends NewsState{
  const NewsLoading();
}

class NewsError extends NewsState{
  final String message;
  const NewsError(this.message);
}

class NewsSuccess extends NewsState{
  final List<NewsArticle> newsArticles;
 const NewsSuccess(this.newsArticles );
}
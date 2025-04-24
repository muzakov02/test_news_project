import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_news_project/cubit/news_cubit.dart';
import 'package:test_news_project/cubit/news_state.dart';
import 'package:test_news_project/home/news_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().getNews();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read later'),
      ),
      body: BlocConsumer<NewsCubit, NewsState>(listener: (context, state) {
        if (state is NewsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      }, builder: (context, state) {
        if (state is NewsLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is NewsSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final newsArticle = state.newsArticles[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      newsArticle.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(newsArticle.title),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat.yMMMMd().format(newsArticle.publishedAt),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: newsArticle.urlToImage.isNotEmpty
                          ? Image.network(
                              newsArticle.urlToImage,
                              width: 90,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 90, height: 60, color: Colors.grey[300]),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                NewsDetailsPage(newsArticle: newsArticle),
                          ));
                    }),
              );
            },
          );
        }
        return SizedBox();
      }),
     
    );
  }
}

import 'package:flutter/material.dart';
import '../model/news_model.dart';

class DetailsPage extends StatelessWidget {
  final NewsArticle article;

  const DetailsPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Display more information about the article here
          ],
        ),
      ),
    );
  }
}

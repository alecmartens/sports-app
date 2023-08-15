import 'package:flutter/material.dart';
import '../model/news_model.dart';

class DetailsPage extends StatelessWidget {
  final NewsArticle article;

  const DetailsPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              article.title,
              style: TextStyle(
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

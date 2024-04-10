import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/news_controller.dart';
import '../model/news_model.dart';
import 'dart:async';

class NewsCarousel extends StatefulWidget {
  const NewsCarousel({Key? key}) : super(key: key);

  @override
  _NewsCarouselState createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  final NewsController newsController = NewsController();
  late Future<List<NewsArticle>> futureNews;
  List<NewsArticle> articlesWithImageErrors = [];

  @override
  void initState() {
    super.initState();
    futureNews = newsController.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsArticle>>(
      future: futureNews,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final validArticles = snapshot.data!
              .where((article) =>
                  article.urlToImage != null &&
                  !articlesWithImageErrors.contains(article))
              .toList();

          return CarouselSlider.builder(
            itemCount: validArticles.length,
            itemBuilder: (context, index, realIndex) {
              var article = validArticles.elementAt(index);

              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                color: Colors.blueGrey,
                child: InkWell(
                  onTap: () => _navigateToUrl(article.url!),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () => _navigateToUrl(article.url!),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              article.urlToImage!,
                              width: 550,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; 
                                }
                                return const CircularProgressIndicator(); 
                              },
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                if (article.imageLoadAttempts >= 2) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    setState(() {
                                      articlesWithImageErrors.add(article);
                                    });
                                  });
                                  return Image.asset(
                                      'assets/images/placeholder.png'); 
                                } else {
                                  article.imageLoadAttempts++;
                                  return const CircularProgressIndicator(); 
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10.0)),
                      Flexible(
                        child: Text(
                          article.description ?? '',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 435,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlayInterval: const Duration(seconds: 10),
              viewportFraction: 0.45,
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const CircularProgressIndicator();
      },
    );
  }

  void _navigateToUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

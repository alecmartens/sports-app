import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/news_controller.dart';
import '../model/news_model.dart';
import 'details_page.dart';

class NewsCarousel extends StatefulWidget {
  @override
  _NewsCarouselState createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  final NewsController newsController = NewsController();
  late Future<List<NewsArticle>> futureNews;

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
                  article.urlToImage != null && !article.hasImageError)
              .toList(); // Convert validArticles to a list

          return CarouselSlider.builder(
            itemCount: validArticles.length,
            itemBuilder: (context, index, realIndex) {
              var article = validArticles.elementAt(index);
              return Card(
                elevation: 10.0,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: Colors.blueGrey,
                child: InkWell(
                  onTap: () => _navigateToUrl(article.url!),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 400.0,
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
                      const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                      InkWell(
                        onTap: () => _navigateToUrl(article.url!),
                        child: SizedBox(
                          width: 500,
                          height: 200,
                          child: ClipRect(
                            child: Image.network(
                              article.urlToImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                article.hasImageError = true;
                                return const SizedBox.shrink(); // Hide the image
                              },
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
                      Flexible(
                        child: Container(
                          width: 500,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10), // Add bottom padding
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
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: 435,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 2), // Adjust this duration
              autoPlayInterval: Duration(seconds: 10), // Adjust this interval
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

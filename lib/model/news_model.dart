class NewsArticle {
  final String title;
  final String? description;
  final String? urlToImage;
  final String? url;
  bool hasImageError; 
  int imageLoadAttempts; 

  NewsArticle({
    required this.title,
    this.description,
    this.urlToImage,
    this.url,
    this.hasImageError = false, 
    this.imageLoadAttempts = 0, 
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? "",
      description: json['description'],
      urlToImage: json['urlToImage'],
      url: json['url'],
    );
  }
}

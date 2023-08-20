class NewsArticle {
  final String title;
  final String? description;
  final String? urlToImage;
  final String? url;
  bool hasImageError; // Property to track image error status
  int imageLoadAttempts; // Property to track how many times we've tried to load the image

  NewsArticle({
    required this.title,
    this.description,
    this.urlToImage,
    this.url,
    this.hasImageError = false, // Initialize with false
    this.imageLoadAttempts = 0, // Initialize with 0
  });

  // A factory method to create a NewsArticle instance from a map (for example, when decoding JSON from an API)
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? "",
      description: json['description'],
      urlToImage: json['urlToImage'],
      url: json['url'],
    );
  }
}

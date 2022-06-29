class NewsModel {
  String? author;
  String? title;
  String? newsSource;
  String? description;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;
  NewsModel(
      {this.author,
      this.title,
      this.newsSource,
      this.description,
      this.urlToImage,
      this.publishedAt,
      this.content});
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json['author'] ,
      title: json['title'],
      newsSource: json['newsSource'] ,
      description: json['description'] ,
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'] ,
    );
  }
}

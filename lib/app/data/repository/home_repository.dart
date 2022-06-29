import 'package:starter/app/data/models/dto/response.dart';
import 'package:starter/base/base_repository.dart';
import 'package:starter/utils/helper/exception_handler.dart';

import '../models/response/news_response.dart';

class HomeRepository extends BaseRepository {
  Future<RepoResponse<List<NewsModel>>> getNewsFeed(
      {String? country,
      bool? isPullToRefresh,
      String? sortUsing,
      bool? sort,
      String categoryName = "technology",
      int? page}) async {
    String key = "9aa7b11c33124191a9c4b73fc9213d9f";

    String url =
        "https://newsapi.org/v2/top-headlines?country=$country&category=$categoryName&pageSize=6&page=$page&apiKey=$key";

    var response = await controller.getNewsFeed(path: url);

    List<NewsModel> news = [];

    if (response is APIException) {
      return RepoResponse(
          error: APIException(message: "error while loading data"));
    } else {
      response.data["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          NewsModel article = NewsModel(
            title: element['title'],
            author: element['url'],
            newsSource: element['source']['name'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
          );
          news.add(article);
        }
      });
      return RepoResponse(data: news);
    }
  }
}

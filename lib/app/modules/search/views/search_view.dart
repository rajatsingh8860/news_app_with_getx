import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:starter/app/data/values/images.dart';
import 'package:starter/app/data/values/strings.dart';
import 'package:starter/app/modules/home/controllers/home_controller.dart';
import 'package:starter/app/modules/home/views/widgets/listtile/news_tile.dart';
import 'package:starter/app/modules/search/controllers/search_controller.dart';
import 'package:starter/app/routes/app_pages.dart';

import '../../../data/models/response/news_response.dart';

class SearchView extends GetView<SearchController> {
  SearchView({Key? key}) : super(key: key);

  HomeController c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff0C54BE),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Obx(() {
          List<NewsModel> searchedNewsModel = c.newsModel
              .where((p) => p.title!
                  .toLowerCase()
                  .contains(controller.searchQuery.value.toLowerCase()))
              .toList();

          int searchedNewsLength = searchedNewsModel.length;

          return SafeArea(
            child: SizedBox(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: const Color(0xffCED3DC),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                      child: TextField(
                        onChanged: (val) {
                          controller.setSearchQuery(val);
                        },
                        autofocus: true,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                          hintText: Strings.searchHintText,
                        ),
                      ),
                    ),
                  ),
                ),
                (searchedNewsLength == 0)
                    ? const Expanded(child:  Center(child: Text(Strings.noResultFound)))
                    : Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: searchedNewsLength,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL, arguments: {
                                    "imageUrl":
                                        searchedNewsModel[i].urlToImage ?? "",
                                    "title": searchedNewsModel[i].title ?? "",
                                    "content":
                                        searchedNewsModel[i].description ?? "",
                                    "author": searchedNewsModel[i].author ?? "",
                                    "newsSource":
                                        searchedNewsModel[i].newsSource ?? "",
                                  });
                                },
                                child: NewsTile(
                                  title: searchedNewsModel[i].title ?? "",
                                  urlToImage: searchedNewsModel[i].urlToImage ?? "",
                                  newsSource: searchedNewsModel[i].newsSource ?? "",
                                ),
                              );
                            }))
              ],
            )),
          );
        }));
  }
}

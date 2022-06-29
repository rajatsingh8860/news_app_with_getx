import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starter/app/data/values/images.dart';
import 'package:starter/app/data/values/strings.dart';
import 'package:starter/app/modules/home/controllers/home_controller.dart';
import 'package:starter/app/modules/home/views/widgets/bottomsheet/category_selection_bottom_sheet.dart';
import 'package:starter/app/modules/home/views/widgets/bottomsheet/country_bottom_sheet.dart';
import 'package:starter/app/modules/home/views/widgets/bottomsheet/filter_bottom_sheet.dart';
import 'package:starter/app/modules/home/views/widgets/bottomsheet/filter_selection_bottom_sheet.dart';
import 'package:starter/app/modules/home/views/widgets/listtile/news_tile.dart';
import 'package:starter/app/routes/app_pages.dart';
import '../../../data/models/response/news_response.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  bool connected = true;
  final scrollController = ScrollController();
  DateTime now = DateTime.now();

  checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      connected = true;
    } else {
      connected = false;
    }
  }

  void setupController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          controller.setCategoryFilter(false);
          controller.getNewsFeedback();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    checkConnection();
    setupController(context);

    return Obx(() {
      List<NewsModel> filteredNewsModel = controller.newsModel
          .where((p) => p.newsSource!
              .toLowerCase()
              .contains(controller.filterParameter.toString().toLowerCase()))
          .toList();

      controller.sortParameter.value == Strings.publishedAt
          ? filteredNewsModel
              .sort((a, b) => a.publishedAt!.compareTo(b.publishedAt!))
          : filteredNewsModel;

      int filteredNewsLength = filteredNewsModel.length;

      return WillPopScope(
          onWillPop: controller.showParentBottomSheet.value
              ? () async {
                  controller.setParentBottomSheet(false);
                  return false;
                }
              : controller.categorySelectionBottomSheet.value
                  ? () async {
                      controller.setCategorySelectionBottomSheet(false);
                      return false;
                    }
                  : controller.showFilterBottomSheet.value
                      ? () async {
                          controller.setFilterBottomSheetParameter(false);
                          return false;
                        }
                      : controller.showBottomSheet.value
                          ? () async {
                              controller.setBottomSheetParameter(false);

                              return false;
                            }
                          : () async {
                              SystemNavigator.pop();
                              return true;
                            },
          child: Scaffold(
              floatingActionButton: (controller.showFilterBottomSheet.value ||
                      controller.isLoading.value ||
                      controller.showBottomSheet.value ||
                      controller.showParentBottomSheet.value ||
                      !connected ||
                      controller.categorySelectionBottomSheet.value)
                  ? null
                  : FloatingActionButton(
                      onPressed: () {
                        controller.setParentBottomSheet(true);
                      },
                      child: const FaIcon(FontAwesomeIcons.filter)),
              bottomSheet: controller.showParentBottomSheet.value
                  ? const FilterSelectionBottomSheet()
                  : controller.categorySelectionBottomSheet.value
                      ? const CategorySelectionBottomSheet()
                      : controller.showFilterBottomSheet.value
                          ? const FilterBottomSheet()
                          : controller.showBottomSheet.value
                              ? const CountryBottomSheet()
                              : null,
              backgroundColor: const Color(0xffF5F9FD),
              body: !connected
                  ? SizedBox(
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Image.asset(
                            Images.internetLogo,
                            width: size.width * 0.70,
                          )),
                          ElevatedButton(
                              onPressed: () {
                                checkConnection();
                                controller.getNewsFeedback();
                              },
                              child: const Text(ErrorMessages.tryAgain))
                        ],
                      ),
                    )
                  : (controller.isLoading.value && controller.newsModel.isEmpty)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : (filteredNewsModel.isEmpty)
                          ? SizedBox(
                              height: size.height,
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(ErrorMessages.noDataFound),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.offAllNamed(Routes.HOME);
                                      },
                                      child: const Text(ErrorMessages.tryAgain))
                                ],
                              ),
                            )
                          : SizedBox(
                              width: size.width,
                              child: Column(
                                children: [
                                  Container(
                                    color: const Color(0xff0C54BE),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 40.0, left: 10),
                                          child: Text(
                                            Strings.myNews,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller
                                                .setBottomSheetParameter(true);
                                          },
                                          child: SafeArea(
                                            bottom: false,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  right: 20,
                                                  bottom: 10),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    Strings.location,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        controller.countryName,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.SEARCH);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        color: const Color(0xffCED3DC),
                                        height: 40.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child:
                                                  Text(Strings.searchHintText),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Icon(Icons.search),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(Strings.topHeadlines),
                                        Row(
                                          children: [
                                            const Text(Strings.sort),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                hint: controller.sortParameter
                                                            .value ==
                                                        Strings.publishedAt
                                                    ? const Text(Strings.newest)
                                                    : const Text(
                                                        Strings.popularity),
                                                items: <String>[
                                                  Strings.newest,
                                                  Strings.popularity
                                                ].map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  if (val == Strings.newest) {
                                                    controller.setSortParameter(
                                                        Strings.publishedAt);
                                                  }
                                                  if (val ==
                                                      Strings.popularity) {
                                                    controller.setSortParameter(
                                                        Strings.popularity);
                                                    ;
                                                  }
                                                  controller
                                                      .setFilterParameter('');
                                                  controller
                                                      .setCategoryName('');
                                                  controller.setSort(true);
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          controller: scrollController,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount: filteredNewsLength,
                                          itemBuilder: (context, i) {
                                            if (i ==
                                                    controller
                                                            .newsModel.length -
                                                        1 &&
                                                controller.pageNo.value != 1 &&
                                                i > 4 &&
                                                !controller.endOfList.value) {
                                              return const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              );
                                            } else {
                                              return InkWell(
                                                onTap: () {
                                                  Get.toNamed(Routes.DETAIL,
                                                      arguments: {
                                                        "imageUrl":
                                                            filteredNewsModel[i]
                                                                .urlToImage!,
                                                        "title":
                                                            filteredNewsModel[i]
                                                                .title!,
                                                        "content":
                                                            filteredNewsModel[i]
                                                                .description!,
                                                        "author":
                                                            filteredNewsModel[i]
                                                                .author!,
                                                        "newsSource":
                                                            filteredNewsModel[i]
                                                                .newsSource!,
                                                      });
                                                },
                                                child: NewsTile(
                                                    title: filteredNewsModel[i]
                                                        .title!,
                                                    urlToImage:
                                                        filteredNewsModel[i]
                                                            .urlToImage!,
                                                    newsSource:
                                                        filteredNewsModel[i]
                                                            .newsSource!),
                                              );
                                            }
                                          }))
                                ],
                              ),
                            )));
    });
  }
}

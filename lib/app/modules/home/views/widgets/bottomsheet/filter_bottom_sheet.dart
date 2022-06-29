import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:starter/app/data/values/strings.dart';

import '../../../controllers/home_controller.dart';

class FilterBottomSheet extends GetView<HomeController> {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {
        controller.setFilterBottomSheetParameter(false);
      },
      builder: (context) {
        return Container(
            height: 270.h,
            width: double.infinity,
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.w, right: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        Strings.filterForSource,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.setFilterBottomSheetParameter(false);
                          },
                          icon: const Icon(Icons.cancel))
                    ],
                  ),
                ),
                const Divider(),

                ListTile(
                  onTap: () {
                    controller.setFilterParameter('');
                    controller.setFilterBottomSheetParameter(false);
                  },
                  dense: true,
                  contentPadding:  EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Text(Strings.allNewsArticles),
                  trailing: (controller.filterParameter.value == "")
                      ? const Icon(Icons.check)
                      : null,
                ),

                const Divider(),

                //1
                ListTile(
                  onTap: () {
                    controller.setFilterParameter(
                        controller.newsModel[0].newsSource!);
                    controller.setFilterBottomSheetParameter(false);
                  },
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(controller.newsModel[0].newsSource!),
                  trailing: (controller.filterParameter.value ==
                          controller.newsModel[0].newsSource!)
                      ? const Icon(Icons.check)
                      : null,
                ),
                const Divider(),

                //2
                ListTile(
                  onTap: () {
                    controller.setFilterParameter(
                        controller.newsModel[1].newsSource!);
                    controller.setFilterBottomSheetParameter(false);
                  },
                  dense: true,
                  contentPadding:  EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(controller.newsModel[1].newsSource!),
                  trailing: (controller.filterParameter.value ==
                          controller.newsModel[1].newsSource!)
                      ? const Icon(Icons.check)
                      : null,
                ),
                const Divider(),

                //3
                ListTile(
                  onTap: () {
                    controller.setFilterParameter(
                        controller.newsModel[2].newsSource!);
                    controller.setFilterBottomSheetParameter(false);
                  },
                  dense: true,
                  contentPadding:  EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(controller.newsModel[2].newsSource!),
                  trailing: (controller.filterParameter.value ==
                          controller.newsModel[2].newsSource!)
                      ? const Icon(Icons.check)
                      : null,
                ),
                const Divider(),
              ],
            ));
      },
    );
  }
}

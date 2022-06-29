import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../../data/values/strings.dart';
import '../../../controllers/home_controller.dart';

class CategorySelectionBottomSheet extends GetView<HomeController> {
  const CategorySelectionBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {
        controller.setBottomSheetParameter(false);
      },
      builder: (context) {
        return Container(
            height: 350.h,
            width: double.infinity,
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.filterByCategory,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.setCategorySelectionBottomSheet(false);
                          },
                          icon: const Icon(Icons.cancel))
                    ],
                  ),
                ),
                const Divider(),

                //0
                ListTile(
                  onTap: () {
                    controller.setCategoryName("");
                    controller.setCategoryFilter(true);
                    controller.setCategorySelectionBottomSheet(false);
                    controller.resetPageNo();
                    controller.getNewsFeedback();
                  },
                  dense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Text(Strings.allCategories),
                  trailing: (controller.categoryName.value == "")
                      ? const Icon(Icons.check)
                      : null,
                ),
                const Divider(),

                //1
                ListTile(
                  onTap: () {
                    controller.setCategoryName(Strings.business);
                    controller.setCategoryFilter(true);
                    controller.resetPageNo();
                    controller.setCategorySelectionBottomSheet(false);
                    controller.getNewsFeedback();
                  },
                  dense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Text(Strings.businessHeading),
                  trailing: (controller.categoryName.value == Strings.business)
                      ? const Icon(Icons.check)
                      : null,
                ),
                const Divider(),

                //2
                ListTile(
                  onTap: () {
                    controller.setCategoryName(Strings.technology);
                    controller.setCategoryFilter(true);
                    controller.resetPageNo();
                    controller.setCategorySelectionBottomSheet(false);
                    controller.getNewsFeedback();
                  },
                  dense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Text(Strings.technologyHeading),
                  trailing: (controller.categoryName.value == Strings.technology)
                      ? const Icon(Icons.check)
                      : null,
                ),
                const Divider(),

                //3
                ListTile(
                  onTap: () {
                    controller.setCategoryName(Strings.entertainment);
                    controller.setCategoryFilter(true);
                    controller.resetPageNo();
                    controller.setCategorySelectionBottomSheet(false);
                    controller.getNewsFeedback();
                  },
                  dense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Text(Strings.entertainmentHeading),
                  trailing: (controller.categoryName.value == Strings.entertainment)
                      ? const Icon(Icons.check)
                      : null,
                ),
                const Divider(),

                //4
                ListTile(
                  onTap: () {
                    controller.setCategoryName(Strings.general);
                    controller.setCategoryFilter(true);
                    controller.resetPageNo();
                    controller.setCategorySelectionBottomSheet(false);
                    controller.getNewsFeedback();
                  },
                  dense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Text(Strings.generalHeading),
                  trailing: (controller.categoryName.value == Strings.general)
                      ? const Icon(Icons.check)
                      : null,
                ),
                const Divider(),

                //5
                ListTile(
                  onTap: () {
                    controller.setCategoryName(Strings.health);
                    controller.setCategoryFilter(true);
                    controller.resetPageNo();
                    controller.setCategorySelectionBottomSheet(false);
                    controller.getNewsFeedback();
                  },
                  dense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Text(Strings.healthHeading),
                  trailing: (controller.categoryName.value == Strings.health)
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

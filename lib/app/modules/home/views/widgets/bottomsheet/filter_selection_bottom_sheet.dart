import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:starter/app/data/values/strings.dart';

import '../../../controllers/home_controller.dart';

class FilterSelectionBottomSheet extends GetView<HomeController> {
  const FilterSelectionBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 150.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                controller.setParentBottomSheet(false);
              },
              icon: const Icon(Icons.cancel)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  controller.setParentBottomSheet(false);
                  controller.setFilterBottomSheetParameter(true);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  height: size.height * 0.10,
                  width: size.width * 0.45,
                  child: const Center(
                      child: Text(
                    Strings.source,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.setParentBottomSheet(false);
                  controller.setCategorySelectionBottomSheet(true);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  height: size.height * 0.10,
                  width: size.width * 0.45,
                  child: const Center(
                      child: Text(
                        Strings.category,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

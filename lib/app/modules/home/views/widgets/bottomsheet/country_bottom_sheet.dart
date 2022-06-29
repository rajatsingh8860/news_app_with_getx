import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:starter/app/data/values/strings.dart';

import '../../../controllers/home_controller.dart';

class CountryBottomSheet extends GetView<HomeController> {
  const CountryBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {
        controller.setBottomSheetParameter(false);
      },
      builder: (context) {
        return Container(
            height: 210.h,
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
                        Strings.chooseYourLocation,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.setBottomSheetParameter(false);
                          },
                          icon: const Icon(Icons.cancel))
                    ],
                  ),
                ),
                const Divider(),

                //1
                ListTile(
                  onTap: () {
                    controller.emptyListValue();
                    controller.setSort(false);

                    controller.setFilterParameter('');
                    controller.setCategoryName('');
                    controller.setCountryName(Strings.india);
                    controller.setCountryIso(Strings.indiaIso);
                    controller.resetPageNo();
                    controller.getNewsFeedback();
                    controller.setBottomSheetParameter(false);
                  },
                  dense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Text(Strings.india),
                  trailing: (controller.countryIso.value == Strings.indiaIso)
                      ? const Icon(Icons.check)
                      : null,
                ),
                const Divider(),

                //2
                ListTile(
                  onTap: () {
                    controller.emptyListValue();
                    controller.setSort(false);
                    controller.setFilterParameter('');
                    controller.setCategoryName('');
                    controller.setCountryName(Strings.usa);
                    controller.setCountryIso(Strings.usaIso);
                    controller.resetPageNo();
                    controller.getNewsFeedback();
                    controller.setBottomSheetParameter(false);
                  },
                  dense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Text(Strings.usa),
                  trailing: (controller.countryIso.value == Strings.usaIso)
                      ? const Icon(Icons.check)
                      : null,
                ),
                const Divider(),

                //3
                ListTile(
                  onTap: () {
                    controller.emptyListValue();
                    controller.setSort(false);
                    controller.setFilterParameter('');
                    controller.setCategoryName('');
                    controller.setCountryName(Strings.sweden);
                    controller.setCountryIso(Strings.swedenIso);
                    controller.resetPageNo();
                    controller.getNewsFeedback();
                    controller.setBottomSheetParameter(false);
                  },
                  dense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Text(Strings.sweden),
                  trailing: (controller.countryIso.value == Strings.swedenIso)
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

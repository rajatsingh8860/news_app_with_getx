import 'package:get/get.dart';
import 'package:starter/app/modules/home/bindings/home_binding.dart';
import 'package:starter/app/modules/home/views/home_view.dart';
import 'package:starter/app/modules/search/bindings/search_binding.dart';

import '../modules/detail/views/detail_view.dart';
import '../modules/search/views/search_view.dart';
part 'app_routes.dart';


class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => const DetailView(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding()
    ),
  ];
}

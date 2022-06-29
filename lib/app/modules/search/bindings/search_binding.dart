import 'package:get/get.dart';
import 'package:starter/app/modules/search/controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}

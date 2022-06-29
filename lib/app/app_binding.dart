import 'package:get/get.dart';
import 'package:starter/app/data/network/network_requester.dart';
import 'package:starter/app/data/repository/home_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeRepository(), permanent: true);
    Get.put(HomeRepository(), permanent: true);
    Get.put(NetworkRequester(), permanent: true);
  }
}

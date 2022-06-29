
import 'package:get/get.dart';

class SearchController  {

  var searchQuery = "".obs;

  void setSearchQuery(String val){
    searchQuery.value =  val;
  }
}

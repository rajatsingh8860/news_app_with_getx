import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:starter/base/base_controller.dart';
import '../../../data/models/response/news_response.dart';
import '../../../data/repository/home_repository.dart';

class HomeController extends BaseController<HomeRepository> {
  RxList<NewsModel> newsModel = RxList<NewsModel>();
  var sortParameter = "Newest".obs;
  var isLoading = true.obs;
  var showBottomSheet = false.obs;
  var countryName = "India";
  var countryIso = "in".obs;
  var sort = false.obs;
  var showFilterBottomSheet = false.obs;
  var filterParameter = "".obs;
  var showParentBottomSheet = false.obs;
  var categorySelectionBottomSheet = false.obs;
  var categoryName = "".obs;
  var connected = true.obs;
  var pageNo = 1.obs;
  var endOfList = false.obs;
  var categoryFilter = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNewsFeedback();
  }

  void getNewsFeedback({bool isPullToRefresh = false}) async {
    if (newsModel.length == 1 || categoryFilter.isTrue) {
      newsModel.value = [];
      isLoading.value = true;
    } else {
      isLoading.value = true;
    }
    var result = await repository.getNewsFeed(
        country: countryIso.value,
        isPullToRefresh: isPullToRefresh,
        sortUsing: sortParameter.value,
        sort: sort.value,
        page: pageNo.value,
        categoryName: categoryName.value);


    if (result.data!.isEmpty) {
      endOfList.value = true;
    }

    pageNo.value = pageNo.value + 1;

    final newsArticles =
        [newsModel.value, result.data!].expand((x) => x).toList();

    newsModel.value = newsArticles;
    isLoading.value = false;
  }

  void setSortParameter(String val) {
    sortParameter.value = val;
  }

  

  void emptyListValue() {
    newsModel.value = [];
  }

  void setCategoryFilter(bool val) {
    categoryFilter.value = val;
  }

  void resetPageNo() {
    pageNo.value = 1;
  }

  void setSort(bool val) {
    sort.value = val;
  }

  void setBottomSheetParameter(bool val) {
    showBottomSheet.value = val;
  }

  void setFilterBottomSheetParameter(bool val) {
    showFilterBottomSheet.value = val;
  }

  void setCountryName(String val) {
    countryName = val;
  }

  void setCountryIso(String val) {
    countryIso.value = val;
  }

  void setFilterParameter(String val) async {
    filterParameter.value = val;
  }

  void setParentBottomSheet(bool val) {
    showParentBottomSheet.value = val;
  }

  void setCategorySelectionBottomSheet(bool val) {
    categorySelectionBottomSheet.value = val;
  }

  void setCategoryName(String val) {
    categoryName.value = val;
  }

  
}

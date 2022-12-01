import 'package:get/get.dart';
import 'package:manga_app/pages/bookcase_page/bookcase_controller.dart';
import 'package:manga_app/pages/login_page/login_controller.dart';
import 'package:manga_app/utils/global_controller.dart';

import '../navigation/navigation_controller.dart';
import '../pages/details_page/book_details_controller.dart';
import '../pages/details_page/comments_page/comments_page_controller.dart';
import '../pages/details_page/reading_page/reading_controller.dart';
import '../pages/grid_page/grid_pages_controller.dart';
import '../pages/home/home_controller.dart';
import '../pages/search_page/search_controller.dart';
import '../pages/user_page/user_controller.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController(), permanent: true);
    Get.put(LoginController());
    Get.put(NavController(),permanent: true);
  }
}

// class BookMarkController {}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => HomeController());
    Get.put(NavController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(SearchController(), permanent: true);
  }
}

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(() => SearchController());
  }
}

class BookCaseBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(() => SearchController());
  }
}

class BookDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookDetailsController());
    Get.lazyPut(() => ReadingController());
  }
}

class CommentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommentsPageController());
  }
}

class GridPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GridPagesController());
  }
}

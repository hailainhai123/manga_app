import 'package:get/get.dart';
import 'package:manga_app/models/grid_novel/grid_novel_model.dart';

import '../../arbe_module/api/api_dio_controller.dart';

class GridPagesController extends GetxController {
  var url = "".obs;
  var gridNovel = <GridNovelModel>[].obs;
  var page = 1.obs;
  var loadMore = true.obs;
  var title = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getGridNovel();
  }

  void getGridNovel() async {
    gridNovel.clear();
    gridNovel.value = await ApiDioController.getGridNovel(url.value, page.value,
        nextPage: (hasNextPage) {
      if (hasNextPage) {
        page.value += 1;
      }
      loadMore.value = hasNextPage;
    });
  }

  void loadMoreNovel() async {
    var list = await ApiDioController.getGridNovel(url.value, page.value,
        nextPage: (hasNextPage) {
      if (hasNextPage) {
        page.value += 1;
      }
      loadMore.value = hasNextPage;
    });
    gridNovel.addAll(list);
  }
}

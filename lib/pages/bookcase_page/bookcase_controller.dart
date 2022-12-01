import 'package:get/get.dart';
import 'package:manga_app/arbe_module/api/api_dio_controller.dart';
import 'package:manga_app/models/home/new_model/novel_response_model.dart';

class BookcaseController extends GetxController {
  RxList<ComicResponseModel> listBookMark = <ComicResponseModel>[].obs;

  @override
  void onInit() {
    getListBookmark();
    // TODO: implement onInit
    super.onInit();
  }

  void getListBookmark() async {
    var list = await ApiDioController.getListBookMark();
    for (var element in list) {
      listBookMark.add(element);
    }
    print('haiabc: ${listBookMark.length}');
  }
}

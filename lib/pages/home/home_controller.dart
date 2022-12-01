import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/arbe_module/api/api_dio_controller.dart';
import 'package:manga_app/arbe_module/event_dispatcher/event_dispatcher.dart';
import 'package:manga_app/arbe_module/event_dispatcher/event_id.dart';
import 'package:manga_app/models/home/new_model/novel_response_model.dart';

import '../../models/banner/model_banner.dart';
import '../../models/home/new_model/categories_novel_model.dart';
import '../../navigation/navigation_controller.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxDouble opacity = 0.0.obs;
  var currentCategoryIndex = 0.obs;
  final RxDouble bgHeight = kBgHeight.obs;
  var scrollController = ScrollController();
  var banners = <BannerModel>[].obs;
  List<String> listCategories =
      ['Novel', 'Self-love', 'Science', 'Romance', '18+', 'Hentai'].obs;

  List<String> listGenres =
      ['Adventure', 'Funny', 'Sport', 'Action', '18+'].obs;
  var listNewRelease = <ComicResponseModel>[].obs;
  var newComics = <ComicResponseModel>[].obs;
  var featured = <ComicResponseModel>[].obs;
  var favorite = ComicResponseModel().obs;
  var categories = <CategoriesNovelModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    EventDispatcher().registerEvent(
      eventId: EventId.onUserLogin,
      callback: (param) => {print('User login')},
    );
  }

  @override
  void onClose() {
    super.onClose();
    EventDispatcher().removeListeners(
      eventId: EventId.onUserLogin,
      callback: (param) => {print('HEHEE')},
    );
  }

  @override
  void onReady() {
    super.onReady();
    scrollController.addListener(_onScrolling);
    loadNewRelease();
    loadBannerImage();
    loadCategories();
    loadFeatured();
    loadFavorite();
    loadNewComic();
  }

  _onScrolling() {
    calculateBgHeight();
    calculateAppbarOpacity();
  }

  calculateAppbarOpacity() {
    double opa = (1 - 0.006 * scrollController.offset).clamp(0.0, 1.0);
    opacity.value = 1 - opa;
  }

  calculateBgHeight() {
    bgHeight.value =
        (kBgHeight - scrollController.offset).clamp(0.0, kBgHeight);
  }

  void selectCategory(int index) {
    currentCategoryIndex.value = index;
  }

  void loadNewRelease() async {
    await ApiDioController.getArrivals()
        .then((data) => {listNewRelease.value = data});
  }

  void loadNewComic() async {
    await ApiDioController.getNewComics()
        .then((data) => newComics.value = data);
  }

  void loadBannerImage() async {
    await ApiDioController.getBanners().then((data) => banners.value = data);
  }

  void loadCategories() async {
    await ApiDioController.getCategories()
        .then((data) => categories.value = data);
  }

  void loadFeatured() async {
    await ApiDioController.getHotNovels().then((data) => featured.value = data);
  }

  void loadFavorite() async {
    await ApiDioController.getTopNovel().then((data) => favorite.value = data);
  }
}

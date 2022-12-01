import 'package:get/route_manager.dart';
import 'package:manga_app/navigation/main_page.dart';
import 'package:manga_app/pages/bookcase_page/bookcase_page.dart';
import 'package:manga_app/pages/home/home_page.dart';
import 'package:manga_app/pages/login_page/login_page.dart';
import 'package:manga_app/pages/ranking_page/ranking_page.dart';

import '../binding/app_binding.dart';
import '../pages/details_page/comments_page/comments_page.dart';
import '../pages/details_page/details_page.dart';
import '../pages/details_page/reading_page/reading_page.dart';
import '../pages/grid_page/grid_novel_page.dart';
import '../pages/search_page/search_page.dart';
import '../pages/search_page/widgets/detail_hottags/hottags_adventure.dart';

const kHomePage = '/home';
const kRouteIndex = "/";
const kSearchPage = '/search';
const kBookCasePage = '/book_case';
const kRankingPage = '/ranking';
const kDetailHotTags = '/detail_hot_tags';
const kBookDetails = '/book_details';
const kReadingPage = '/reading/:id';
const kListChapPage = '/list_chap/:id';
const kLoginPage = '/login';
const kRegisterPage = '/register';
const kCommentsPage = '/comments/:id';
const kNotificationPage = '/notification';
const kGridNovelPage = '/grid_novel';
const kEditPage = '/edit';

final indexPage = GetPage(
    name: kRouteIndex,
    page: () => MainPage(),
    bindings: [GlobalBinding(), HomeBinding()]);

final homePage = GetPage(
    name: kHomePage, page: () => const HomePage(), binding: HomeBinding());

final loginPage = GetPage(
    name: kLoginPage, page: () => LoginPage(), binding: GlobalBinding());

final bookcasePage = GetPage(
  name: kBookCasePage,
  page: () => BookCasePage(),
);

final rankingPage = GetPage(
  name: kRankingPage,
  page: () => RankingPage(),
);

final detailHotTags = GetPage(
  name: kDetailHotTags,
  page: () => const Adventure(),
);

//Book details
final detailsPage = GetPage(
    name: kBookDetails,
    page: () => const BookDetailsPage(),
    binding: BookDetailsBinding());

final readingPage = GetPage(
    name: kReadingPage,
    page: () => ReadingPage(),
    binding: BookDetailsBinding());

final searchPage = GetPage(
    name: kSearchPage,
    page: () => const SearchPage(),
    bindings: [SearchBinding()]);

final commentsPage = GetPage(
    name: kCommentsPage,
    page: () => const CommentsPage(),
    binding: CommentsBinding());

final gridNovelPage = GetPage(
    name: kGridNovelPage,
    page: () => const GridNovelPage(),
    binding: GridPageBinding());

final List<GetPage> pages = [
  indexPage,
  loginPage,
  homePage,
  bookcasePage,
  rankingPage,
  detailHotTags,
  searchPage,
  detailsPage,
  readingPage,
  commentsPage,
  gridNovelPage
];

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manga_app/pages/search_page/search_controller.dart';
import 'package:manga_app/pages/search_page/widgets/hot_tag_manga.dart';
import 'package:manga_app/pages/search_page/widgets/hot_tags_widget.dart';
import 'package:manga_app/pages/search_page/widgets/recent_search_widget.dart';
import 'package:manga_app/pages/search_page/widgets/search_widget.dart';
import 'package:manga_app/pages/search_page/widgets/top_book_search.dart';
import 'package:manga_app/pages/search_page/widgets/trending_search.dart';

import '../../constant/icons_path.dart';
import '../../constant/styles.dart';
import '../../constant/theme.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));

    final controller = Get.find<SearchController>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kPrimaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Search(),
                TrendingSearch(),
                HotTags(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:manga_app/pages/home/widgets/detail_release_widget.dart';
import 'package:manga_app/pages/home/widgets/featured_widget.dart';
import 'package:manga_app/pages/home/widgets/genres_widget.dart';
import 'package:manga_app/pages/home/widgets/manga_favorite_widget.dart';
import 'package:manga_app/pages/home/widgets/new_release_widget.dart';
import 'package:manga_app/pages/home/widgets/other_manga_widget.dart';
import 'package:manga_app/pages/home/widgets/sliver_bar.dart';

import '../../constant/routers.dart';
import '../../constant/theme.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: kPrimaryColor));

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Container(
              color: Colors.transparent,
              // height: 80,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(kSearchPage);
                    },
                    child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(24)),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            expandedHeight: 401,
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(bottom: 16),
              centerTitle: true,
              background: ExpandedImage(),
            ),
          ),
          const GenresWidget(),
          const NewReleaseWidget(),
          const DetailRelease(),
          const Featured(),
          const MangaFavorite(),
          const OtherManga(),
        ]),
      ),
    );
  }
}

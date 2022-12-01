import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/pages/bookcase_page/bookcase_page.dart';
import 'package:manga_app/pages/ranking_page/ranking_page.dart';

import '../pages/home/home_page.dart';
import '../pages/user_page/user_page.dart';
import 'navigation_bar.dart';
import 'navigation_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final pages = [
    const HomePage(),
    BookCasePage(),
    const RankingPage(),
    const UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavController>();

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Obx(() {
        return pages[navController.currentIndex.value];
      }),
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: NavigationBottomBar(),
        ),
      ),
    );
  }
}

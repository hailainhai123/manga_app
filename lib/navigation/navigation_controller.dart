import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/icons_path.dart';
import 'navigation_bar.dart';
const kBgHeight = 200.0;

class NavController extends GetxController with GetSingleTickerProviderStateMixin{
  var currentIndex = 0.obs;

  late AnimationController _controller;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final icons = <BottomNav>[
    BottomNav(icon: IconsPath.navHomeIcon, title: "Truyện Tranh"),
    BottomNav(icon: IconsPath.navBookmarkIcon, title: "Tủ Sách"),
    BottomNav(icon: IconsPath.navRankingIcon, title: "Xếp hạng"),
    BottomNav(icon: IconsPath.navUserIcon, title: "Tôi"),
  ];
  late Animation<double> animation;

  @override
  void onInit() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.onInit();
  }


  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }
}
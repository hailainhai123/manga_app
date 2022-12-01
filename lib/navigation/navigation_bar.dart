import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constant/theme.dart';
import 'navigation_controller.dart';

class BottomNav {
  final String icon;
  final String title;

  BottomNav({required this.icon, required this.title});
}

class NavigationBottomBar extends GetView<NavController> {
  NavigationBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedBottomNavigationBar.builder(
          itemCount: controller.icons.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? kSecondaryColor : Color(0xffffffff);
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(controller.icons[index].icon, color: color),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    controller.icons[index].title,
                    style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            );
          },

          backgroundColor: kPrimaryColor.withOpacity(0.6),
          activeIndex: controller.currentIndex.value,
          // splashColor: HexColor('#FFA400'),
          notchAndCornersAnimation: controller.animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.none,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          onTap: (index) => {controller.currentIndex.value = index},
        ));
  }
}

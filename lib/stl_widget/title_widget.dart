import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_app/constant/styles.dart';

import '../constant/api_url.dart';
import '../constant/routers.dart';
import '../pages/home/home_controller.dart';

class ChildHomeWidget extends GetView<HomeController> {
  final Widget child;
  final bool showRight;
  final String title;
  final String url;

  const ChildHomeWidget(
      {Key? key,
      required this.child,
      this.showRight = true,
      required this.url,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: GoogleFonts.lora(
                      fontSize: 20, fontWeight: FontWeight.w700)),
              if (showRight)
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/grid_novel",
                        parameters: {'title': title, 'url': url});
                  },
                  child: Row(
                    children: [
                      Text('Xem thêm',
                          style: Styles.interFont.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                )
            ],
          ),
          const SizedBox(height: 14),
          child
        ],
      ),
    );
  }
}

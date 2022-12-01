import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/constant/routers.dart';
import 'package:simple_tags/simple_tags.dart';

import '../../../constant/theme.dart';

class HotTagManga extends StatelessWidget {
   HotTagManga({Key? key}) : super(key: key);

  List<String> hotTagExample = ['#tokyorevengers', '#conan', '#doraemon', '#one', '#kimetsu', '#action', '#adventure'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SimpleTags(
          content: hotTagExample,
          wrapSpacing: 8,
          wrapRunSpacing: 4,
          tagContainerPadding: const EdgeInsets.all(6),
          onTagPress: (val) {
            Get.toNamed(kDetailHotTags);
          },
          tagTextStyle: const TextStyle(color: Colors.white),
          tagContainerDecoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ))),
    );
  }
}

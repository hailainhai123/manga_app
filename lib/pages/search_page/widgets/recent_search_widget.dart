import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tags/simple_tags.dart';

import '../../../constant/styles.dart';
import '../../../constant/theme.dart';
import '../search_controller.dart';

class RecentSearchWidget extends GetView<SearchController> {
  const RecentSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text('Recent', style: Styles.titleTextStyles),
          ),
          Obx(() {
            return SimpleTags(
                content: controller.listRecentSearch.value,
                wrapSpacing: 4,
                wrapRunSpacing: 4,
                tagContainerPadding: const EdgeInsets.all(6),
                onTagPress: (val) {
                  controller.listRecentSearch.remove(val);
                },
                tagTextStyle: const TextStyle(color: kPrimaryColor),
                tagIcon: const Icon(
                  Icons.clear,
                  size: 12,
                  color: kPrimaryColor,
                ),
                tagContainerDecoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.15),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    )));
          })
        ],
      ),
    );
  }
}

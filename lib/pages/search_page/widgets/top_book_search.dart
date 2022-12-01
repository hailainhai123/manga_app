import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constant/icons_path.dart';
import '../../../constant/styles.dart';
import '../../../constant/theme.dart';

class TopBookSearch extends StatelessWidget {
  const TopBookSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: Row(
              children: [
                SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(IconsPath.baseImage,
                          fit: BoxFit.cover),
                    )),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Someone Like You',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      Text('Roald Dahl',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: kGreyColor)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        childCount: 10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 3.4,
      ),
    );
  }
}

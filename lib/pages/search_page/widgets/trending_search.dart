import 'package:flutter/material.dart';
import 'package:manga_app/stl_widget/title_widget.dart';

import '../../../constant/icons_path.dart';
import '../../../constant/styles.dart';

class TrendingSearch extends StatelessWidget {
  const TrendingSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChildHomeWidget(
        title: 'Trending Search',
        showRight: false,
        url: "",
        child: SizedBox(
          height: 400,
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  height: 167,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(IconsPath.baseImage),
                        fit: BoxFit.cover),
                  ),
                  margin: const EdgeInsets.only(right: 16, bottom: 16),
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: 16,
                      left: 16,
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color(0xff1f1f1f).withOpacity(0.1),
                        Color(0xff1f1f1f)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text('Dragon Ball',
                            style: Styles.notoSansFont.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}

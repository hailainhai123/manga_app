import 'package:flutter/material.dart';
import 'package:manga_app/pages/search_page/widgets/hot_tag_manga.dart';
import 'package:manga_app/stl_widget/title_widget.dart';

class HotTags extends StatelessWidget {
  const HotTags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChildHomeWidget(
      title: 'Hot tags',
      showRight: false,
      url: "",
      child: HotTagManga(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/constant/api_url.dart';

import '../../../constant/icons_path.dart';
import '../../../constant/theme.dart';
import '../../../stl_widget/title_widget.dart';
import '../home_controller.dart';

class NewReleaseWidget extends StatelessWidget {

  //TODO Thay list fake bằng GetxController cùng listTitle
  const NewReleaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const SliverToBoxAdapter(
      child: ChildHomeWidget(
        title: 'Truyện mới cập nhật',
        showRight: true,
        url: ApiURL.arrivalUrl,
        child: SizedBox(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/pages/home/home_controller.dart';

class ExpandedImage extends GetView<HomeController> {
  const ExpandedImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/bg_home.png',
              ),
              fit: BoxFit.cover)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Manga',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
            const Text('JUJUTSU KAISEN',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Fantasy',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Love',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                ),
                Text('Adventure',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

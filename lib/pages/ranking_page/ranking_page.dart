import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/icons_path.dart';
import '../../constant/routers.dart';
import '../../constant/styles.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xếp hạng',style: GoogleFonts.notoSans(
            fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        // height: double.infinity,
        child: Column(
          children: [
            Divider(),
            Expanded(
              child: InkWell(
                onTap: (){
                  Get.toNamed(kBookDetails);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: 10,
                      // scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ItemView(index);
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ItemView(int index) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 76,
                child: Image.asset(
                  IconsPath.baseImage,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 40
              ),
              Text('${index +1}',
                  style: GoogleFonts.lora(
                      fontSize: 24, fontWeight: FontWeight.w700)),
              SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Text('Jujutsu Kaisen',
                      style: GoogleFonts.notoSans(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  Text('Gege Akutami',
                      style: GoogleFonts.notoSans(
                          fontSize: 14, fontWeight: FontWeight.w400,color: const Color(0xffC0C2C3))),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/constant/routers.dart';

import '../../../../constant/icons_path.dart';

class Adventure extends StatelessWidget {
  const Adventure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adventure'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 0.75,),
          itemCount: 10,
          itemBuilder: (context, index){
            return itemView(context);
          }
        ),
      ),
    );
  }

  Widget itemView(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(left: 16,),
      height: 187,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
              height: 187,
              width: MediaQuery.of(context).size.width / 2 - 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child:
                Image.asset(IconsPath.baseImage, fit: BoxFit.cover),
              )),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Someone Like You',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

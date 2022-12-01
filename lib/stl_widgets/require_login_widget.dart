import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/constant/routers.dart';

class RequireLoginWidget extends StatelessWidget {
  const RequireLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text('Vui lòng đăng nhập hoặc đăng ký.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(kLoginPage, arguments: {"showBackIcon": true});
                  },
                  child: const Text('Đăng nhập')),
              const SizedBox(width: 16),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(kRegisterPage,
                        arguments: {"showBackIcon": true});
                  },
                  child: const Text('Đăng ký')),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_app/constant/icons_path.dart';
import 'package:manga_app/pages/login_page/login_controller.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset(IconsPath.logoApp)),
                  const Text('Comic 3k',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const Text(
                    'Chào mừng bạn trở lại',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  const SizedBox(height: 120),
                  SizedBox(
                    height: 60,
                    child: SignInButton(
                      Buttons.google,
                      text: "Đăng nhập với Google",
                      padding: const EdgeInsets.all(15),
                      onPressed: () async {
                        controller.signInWithGoogle();
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    height: 60,
                    child: SignInButton(
                      Buttons.facebookNew,
                      text: "Đăng nhập với Facebook",
                      padding: const EdgeInsets.all(15),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                      width: 250,
                      height: 60,
                      child: SignInWithAppleButton(onPressed: () {
                        controller.signInWithApple();
                      })),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

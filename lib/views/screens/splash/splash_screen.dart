import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/image_constant.dart';
import 'package:aqua_task/view_models/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: Image.asset(
              ImageConstant.aquaTaskLogo,
              height: 180,
              width: 180,
            ),
          ),
        );
      },
    );
  }
}

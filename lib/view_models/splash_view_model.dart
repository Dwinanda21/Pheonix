import 'dart:async';

import 'package:get/get.dart';
import 'package:aqua_task/constant/name_route_constant.dart';
import 'package:aqua_task/helpers/shared_pref_helper.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    SharedPrefHelper.getUsername().then((username) {
      if (username.isNotEmpty) {
        Timer(
          const Duration(seconds: 1),
          () => Get.offAllNamed(NameRouteConstant.homeScreen),
        );
      } else {
        Timer(
          const Duration(seconds: 2),
          () => Get.offAllNamed(NameRouteConstant.loginScreen),
        );
      }
    });
  }
}

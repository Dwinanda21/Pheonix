import 'package:get/get.dart';

class GlobalBottomNavbarViewModel extends GetxController {
  var currentIndex = 0.obs;

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}

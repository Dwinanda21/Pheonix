import 'package:get/get.dart';
import 'package:aqua_task/constant/name_route_constant.dart';
import 'package:aqua_task/views/global_widgets/global_bottom_navbar_widget.dart';
import 'package:aqua_task/views/screens/login/login_screen.dart';
import 'package:aqua_task/views/screens/splash/splash_screen.dart';

class NameScreenConstant {
  static final routes = [
    GetPage(
      name: NameRouteConstant.initRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: NameRouteConstant.loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: NameRouteConstant.homeScreen,
      page: () => const GlobalBottomNavbarWidget(),
    ),
  ];
}

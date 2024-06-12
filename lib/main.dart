import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/name_route_constant.dart';
import 'package:aqua_task/constant/name_screen_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', '');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstant.primary),
        scaffoldBackgroundColor: ColorConstant.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorConstant.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: NameRouteConstant.initRoute,
      getPages: NameScreenConstant.routes,
    );
  }
}

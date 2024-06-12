import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/name_route_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:aqua_task/view_models/home_view_model.dart';
import 'package:aqua_task/views/screens/home/widgets/home_change_username_widget.dart';
import 'package:aqua_task/views/screens/home/widgets/home_save_change_button_widget.dart';

class HomeProfileBottomSheetWidget extends StatelessWidget {
  const HomeProfileBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => homeViewModel.imageFile.value == null
                ? const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  )
                : CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(homeViewModel.imageFile.value!),
                  )),
            TextButton(
              onPressed: homeViewModel.pickImage,
              child: const Text('Ubah Foto Profil'),
            ),
            const HomeChangeUsernameWidget(),
            const SizedBox(height: 16),
            const HomeSaveChangeButtonWidget(),
            TextButton(
              onPressed: () async {
                await homeViewModel.clearUserData();
                Get.offAllNamed(NameRouteConstant.loginScreen);
              },
              child: Text(
                'Keluar',
                style: TextStyleConstant.bodyMedium.copyWith(
                  color: ColorConstant.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

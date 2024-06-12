import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/view_models/home_view_model.dart';
import 'package:aqua_task/views/global_widgets/global_button_widget.dart';

class HomeSaveChangeButtonWidget extends StatelessWidget {
  const HomeSaveChangeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());

    return Obx(
      () => GlobalFormButtonWidget(
        text: 'Simpan Perubahan',
        onTap: () async {
          await homeViewModel.saveChanges();
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
        isLoading: homeViewModel.isLoading.value,
        isFormValid: homeViewModel.isFormValid.value,
      ),
    );
  }
}

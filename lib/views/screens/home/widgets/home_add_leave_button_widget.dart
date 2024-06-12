import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/view_models/home_view_model.dart';
import 'package:aqua_task/views/global_widgets/global_button_widget.dart';

class HomeAddLeaveButtonWidget extends StatelessWidget {
  const HomeAddLeaveButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());

    return Obx(
      () => GlobalFormButtonWidget(
        text: 'Ajukan Cuti',
        onTap: () async {
          await homeViewModel.addLeave();
        },
        isLoading: homeViewModel.isLoading.value,
        isFormValid: homeViewModel.isLeaveValid.value,
      ),
    );
  }
}

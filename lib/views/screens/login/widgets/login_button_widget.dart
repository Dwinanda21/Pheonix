import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/view_models/login_view_model.dart';
import 'package:aqua_task/views/global_widgets/global_button_widget.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = Get.put(LoginViewModel());

    return Obx(
      () => GlobalFormButtonWidget(
        text: 'Masuk',
        onTap: loginViewModel.login,
        isLoading: loginViewModel.isLoading.value,
        isFormValid: loginViewModel.isFormValid.value,
      ),
    );
  }
}

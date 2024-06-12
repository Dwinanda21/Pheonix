import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/view_models/login_view_model.dart';
import 'package:aqua_task/views/global_widgets/global_text_form_field_widget.dart';

class LoginUsernameFormWidget extends StatelessWidget {
  const LoginUsernameFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = Get.put(LoginViewModel());

    return Obx(
      () => GlobalTextFormFieldWidget(
        controller: loginViewModel.usernameController,
        focusNode: loginViewModel.usernameFocusNode,
        labelText: 'Nama pengguna',
        hintText: 'Masukkan nama pengguna kamu!',
        prefixIcon: const Icon(Icons.person),
        keyboardType: TextInputType.name,
        errorText: loginViewModel.usernameErrorText.value,
        onChanged: (value) => loginViewModel.validateUsername(value),
      ),
    );
  }
}

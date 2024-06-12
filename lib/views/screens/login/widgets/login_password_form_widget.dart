import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/view_models/login_view_model.dart';
import 'package:aqua_task/views/global_widgets/global_text_form_field_widget.dart';

class LoginPasswordFormWidget extends StatelessWidget {
  const LoginPasswordFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = Get.put(LoginViewModel());

    return Obx(
      () => GlobalTextFormFieldWidget(
        controller: loginViewModel.passwordController,
        focusNode: loginViewModel.passwordFocusNode,
        labelText: 'Kata Sandi',
        hintText: 'Masukkan kata sandi kamu!',
        prefixIcon: const Icon(Icons.lock),
        obsecureText: loginViewModel.obscureText.value,
        keyboardType: TextInputType.text,
        errorText: loginViewModel.passwordErrorText.value,
        onChanged: (value) => loginViewModel.validatePassword(value),
        onPressedSuffixIcon: () {
          loginViewModel.toggleObsecureText();
        },
        suffixIcon: loginViewModel.obscureText.value
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility),
      ),
    );
  }
}

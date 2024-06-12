import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/name_route_constant.dart';
import 'package:aqua_task/helpers/shared_pref_helper.dart';
import 'package:aqua_task/models/user_model.dart';

class LoginViewModel extends GetxController {
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  Rx<String?> username = Rx<String?>(null);
  Rx<String?> password = Rx<String?>(null);
  Rx<String?> usernameErrorText = Rx<String?>(null);
  Rx<String?> passwordErrorText = Rx<String?>(null);
  Rx<bool> isUsernameValid = Rx<bool>(false);
  Rx<bool> isPasswordValid = Rx<bool>(false);
  Rx<bool> isFormValid = Rx<bool>(false);
  Rx<bool> isLoading = Rx<bool>(false);
  Rx<bool> obscureText = false.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void onInit() {
    usernameController.addListener(validateForm);
    passwordController.addListener(validateForm);
    usernameFocusNode.addListener(() => update());
    passwordFocusNode.addListener(() => update());
    super.onInit();
  }

  void validateUsername(String value) {
    if (value.isEmpty) {
      usernameErrorText.value = 'Nama tidak boleh kosong';
      isUsernameValid.value = false;
    } else if (value.length < 3) {
      usernameErrorText.value = 'Nama harus minimal 3 karakter';
      isUsernameValid.value = false;
    } else if (RegExp(r'[^a-zA-Z0-9\s]').hasMatch(value)) {
      usernameErrorText.value = 'Nama tidak boleh mengandung karakter spesial';
      isUsernameValid.value = false;
    } else {
      usernameErrorText.value = null;
      isUsernameValid.value = true;
    }
    validateForm();
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordErrorText.value = 'Kata sandi tidak boleh kosong';
      isPasswordValid.value = false;
    } else if (value.length < 8) {
      passwordErrorText.value = 'Kata sandi harus minimal 8 karakter';
      isPasswordValid.value = false;
    } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      passwordErrorText.value = 'Kata sandi harus mengandung huruf kecil';
      isPasswordValid.value = false;
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      passwordErrorText.value = 'Kata sandi harus mengandung huruf besar';
      isPasswordValid.value = false;
    } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      passwordErrorText.value = 'Kata sandi harus mengandung angka';
      isPasswordValid.value = false;
    } else if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
      passwordErrorText.value = 'Kata sandi harus mengandung karakter spesial';
      isPasswordValid.value = false;
    } else {
      passwordErrorText.value = null;
      isPasswordValid.value = true;
    }
    validateForm();
  }

  void validateForm() {
    if (isUsernameValid.value && isPasswordValid.value) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  void toggleObsecureText() {
    obscureText.value = !obscureText.value;
  }

  void clearForm() {
    usernameController.clear();
    passwordController.clear();
    usernameFocusNode.unfocus();
    passwordFocusNode.unfocus();
    usernameErrorText.value = null;
    passwordErrorText.value = null;
    isUsernameValid.value = false;
    isPasswordValid.value = false;
    isFormValid.value = false;
  }

  void login() async {
    isLoading.value = true;
    await Future.delayed(
      const Duration(seconds: 2),
      () async {
        isLoading.value = false;
        userModel.value = UserModel(
          username: usernameController.text,
          password: passwordController.text,
        );
        await SharedPrefHelper.saveUsername(usernameController.text);
        clearForm();
        Get.offAllNamed(NameRouteConstant.homeScreen);
      },
    );
  }
}

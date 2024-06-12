import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/view_models/home_view_model.dart';
import 'package:aqua_task/views/global_widgets/global_text_form_field_widget.dart';

class HomeChangeUsernameWidget extends StatelessWidget {
  const HomeChangeUsernameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());

    return Obx(
      () => GlobalTextFormFieldWidget(
        controller: homeViewModel.usernameController,
        focusNode: homeViewModel.usernameFocusNode,
        labelText: 'Ubah nama',
        hintText: 'Silahkan ubah nama kamu',
        keyboardType: TextInputType.name,
        errorText: homeViewModel.usernameErrorText.value,
        onChanged: (value) => homeViewModel.validateUsername(value),
      ),
    );
  }
}

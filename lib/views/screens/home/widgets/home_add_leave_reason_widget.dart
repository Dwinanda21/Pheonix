import 'package:aqua_task/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/view_models/home_view_model.dart';

class HomeAddLeaveReasonWidget extends StatelessWidget {
  const HomeAddLeaveReasonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());

    return Obx(
      () => Expanded(
        child: TextField(
          controller: homeViewModel.reasonController.value,
          focusNode: homeViewModel.reasonFocusNode.value,
          decoration: InputDecoration(
            labelText: 'Keterangan',
            hintText: 'Keterangan minimal 10 kata',
            errorText: homeViewModel.reasonErrorText.value,
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorConstant.primaryHover,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorConstant.primary,
                width: 0.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorConstant.error,
                width: 0.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorConstant.errorFocused,
                width: 0.5,
              ),
            ),
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: (value) => homeViewModel.validateReason(value),
        ),
      ),
    );
  }
}

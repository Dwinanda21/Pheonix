import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:aqua_task/view_models/home_view_model.dart';

class HomeAddLeaveDateWidget extends StatelessWidget {
  const HomeAddLeaveDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel =
        Get.put(HomeViewModel(), permanent: true);

    return Expanded(
      child: Obx(
        () => homeViewModel.selectedStartDate.value != null &&
                homeViewModel.selectedEndDate.value != null
            ? Text(
                '${homeViewModel.formatDate(
                  homeViewModel.startDate.value,
                )} - ${homeViewModel.formatDate(homeViewModel.endDate.value)}',
                style: TextStyleConstant.captionMedium,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

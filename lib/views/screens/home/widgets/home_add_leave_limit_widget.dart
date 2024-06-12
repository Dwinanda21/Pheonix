import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:aqua_task/view_models/home_view_model.dart';

class HomeAddLeaveLimitWidget extends StatelessWidget {
  const HomeAddLeaveLimitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Kuota cuti tahun ini:',
            style: TextStyleConstant.captionLarge
                .copyWith(fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
              homeViewModel.remainingLeaveDays.value = 12;
            },
            child: Text(
              '${homeViewModel.remainingLeaveDays.value} hari',
              style: TextStyleConstant.captionLarge.copyWith(
                  fontWeight: FontWeight.w600, color: ColorConstant.primary),
            ),
          )
        ],
      ),
    );
  }
}

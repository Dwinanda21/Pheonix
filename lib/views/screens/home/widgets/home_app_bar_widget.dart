import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:aqua_task/view_models/home_view_model.dart';
import 'package:aqua_task/views/screens/home/widgets/home_profile_bottom_sheet_widget.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const HomeProfileBottomSheetWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());

    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorConstant.primary.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _showBottomSheet(context),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConstant.backgroundColor,
                    width: 1.6,
                  ),
                ),
                child: homeViewModel.imageFile.value == null
                    ? const CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.person, size: 24),
                      )
                    : CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            FileImage(homeViewModel.imageFile.value!),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang,',
                    style: TextStyleConstant.titleSmall.copyWith(
                      color: ColorConstant.backgroundColor,
                    ),
                  ),
                  Text(homeViewModel.username.value ?? 'User',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyleConstant.captionLarge.copyWith(
                        color: ColorConstant.background2Color,
                      )),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Get.snackbar(
                'Segera Hadir!',
                'Fitur masih dalam tahap pengembangan.',
                backgroundColor: ColorConstant.primary,
                colorText: ColorConstant.backgroundColor,
                snackPosition: SnackPosition.BOTTOM,
                borderRadius: 16,
                margin: const EdgeInsets.all(16),
                borderWidth: 2,
                borderColor: ColorConstant.backgroundColor,
                isDismissible: true,
                duration: const Duration(seconds: 2),
                animationDuration: const Duration(milliseconds: 400),
                forwardAnimationCurve: Curves.fastOutSlowIn,
                reverseAnimationCurve: Curves.easeOut,
                icon: const Icon(
                  Icons.info_outline,
                  color: ColorConstant.backgroundColor,
                ),
                shouldIconPulse: true,
              ),
              icon: const Icon(
                Icons.notifications,
                color: ColorConstant.backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

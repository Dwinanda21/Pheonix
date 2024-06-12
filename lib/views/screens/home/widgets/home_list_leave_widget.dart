import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/image_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:aqua_task/helpers/leave_type_helper.dart';
import 'package:aqua_task/view_models/home_view_model.dart';
import 'package:aqua_task/views/screens/detail_leave/detail_leave_screen.dart';

class HomeListLeaveWidget extends StatelessWidget {
  const HomeListLeaveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());

    return Column(
      children: [
        Obx(
          () => homeViewModel.leaves.isEmpty
              ? Column(
                  children: [
                    Image.asset(
                      ImageConstant.leaveListEmpty,
                    ),
                    Text(
                      'Kamu belum mengajukan cuti nih!',
                      style: TextStyleConstant.titleLarge,
                      textAlign: TextAlign.center,
                    )
                  ],
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemCount: homeViewModel.leaves.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final leave = homeViewModel.leaves[index];
                    Color backgroundColor = index % 2 == 0
                        ? ColorConstant.background2Color
                        : ColorConstant.background2Color.withOpacity(0.2);
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => DetailLeaveScreen(
                                leaveModel: leave,
                              ));
                        },
                        onLongPress: () {
                          homeViewModel.deleteLeave(leave.id!);
                          Get.snackbar(
                            'Berhasil dihapus',
                            'Riwayat cuti berhasil dihapus',
                            backgroundColor: ColorConstant.primary,
                            colorText: ColorConstant.backgroundColor,
                            snackPosition: SnackPosition.BOTTOM,
                            borderRadius: 16,
                            margin: const EdgeInsets.all(16),
                            borderWidth: 2,
                            borderColor: ColorConstant.backgroundColor,
                            isDismissible: true,
                            duration: const Duration(seconds: 2),
                            animationDuration:
                                const Duration(milliseconds: 400),
                            forwardAnimationCurve: Curves.fastOutSlowIn,
                            reverseAnimationCurve: Curves.easeOut,
                            icon: const Icon(
                              Icons.info_outline,
                              color: ColorConstant.backgroundColor,
                            ),
                            shouldIconPulse: true,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${homeViewModel.formatDate(leave.startDate)} - ${homeViewModel.formatDate(leave.endDate)} (${leaveTypeToString(leave.leaveType)})',
                                  style:
                                      TextStyleConstant.captionMedium.copyWith(
                                    color: ColorConstant.black.withOpacity(0.8),
                                  ),
                                ),
                                Text(
                                  ' - Sedang diajukan',
                                  style:
                                      TextStyleConstant.captionLarge.copyWith(
                                    color: ColorConstant.black.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              leave.reason,
                              style: TextStyleConstant.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

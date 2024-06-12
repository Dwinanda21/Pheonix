import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:aqua_task/helpers/leave_type_helper.dart';
import 'package:aqua_task/models/leave_model.dart';
import 'package:aqua_task/view_models/home_view_model.dart';

class DetailLeaveScreen extends StatelessWidget {
  final LeaveModel leaveModel;
  const DetailLeaveScreen({super.key, required this.leaveModel});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel =
        Get.put(HomeViewModel(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConstant.background2Color,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Pengajuan Cuti',
          style: TextStyleConstant.titleSmall.copyWith(
            color: ColorConstant.background2Color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leaveModel.reason,
                style: TextStyleConstant.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '${homeViewModel.formatDate(leaveModel.startDate)} - ${homeViewModel.formatDate(leaveModel.endDate)}',
                    style: TextStyleConstant.captionMedium.copyWith(
                      color: ColorConstant.black.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    ' - ${leaveTypeToString(leaveModel.leaveType)}',
                    style: TextStyleConstant.bodySmall.copyWith(
                      color: ColorConstant.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  style: TextStyleConstant.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Status: ',
                      style: TextStyleConstant.bodySmall.copyWith(
                        color: ColorConstant.black.withOpacity(0.8),
                      ),
                    ),
                    TextSpan(
                      text: 'Sedang diajukan',
                      style: TextStyleConstant.bodySmall.copyWith(
                        color: ColorConstant.black.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

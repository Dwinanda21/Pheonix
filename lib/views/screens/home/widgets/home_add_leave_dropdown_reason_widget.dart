import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:aqua_task/helpers/leave_type_helper.dart';
import 'package:aqua_task/view_models/home_view_model.dart';

class HomeAddLeaveDropdownReasonWidget extends StatelessWidget {
  const HomeAddLeaveDropdownReasonWidget({super.key});
  IconData leaveTypeToIcon(LeaveTypeHelper type) {
    switch (type) {
      case LeaveTypeHelper.annual:
        return Icons.beach_access;
      case LeaveTypeHelper.sick:
        return Icons.local_hospital;
      case LeaveTypeHelper.special:
        return Icons.event;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.put(HomeViewModel());

    return Obx(
      () => DropdownButton<LeaveTypeHelper>(
        value: homeViewModel.selectedLeaveType.value,
        onChanged: (LeaveTypeHelper? newValue) {
          homeViewModel.selectedLeaveType.value = newValue!;
        },
        items: LeaveTypeHelper.values.map(
          (LeaveTypeHelper leaveType) {
            return DropdownMenuItem<LeaveTypeHelper>(
              value: leaveType,
              child: Row(
                children: [
                  Icon(
                    leaveTypeToIcon(leaveType),
                    size: 22,
                    color: ColorConstant.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    leaveTypeToString(leaveType),
                    style: TextStyleConstant.bodySmall,
                  ),
                ],
              ),
            );
          },
        ).toList(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: ColorConstant.primary,
        ),
        underline: Container(
          height: 2,
          color: ColorConstant.secondary,
        ),
      ),
    );
  }
}

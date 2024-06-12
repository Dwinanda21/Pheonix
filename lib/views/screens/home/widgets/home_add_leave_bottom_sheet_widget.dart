import 'package:flutter/material.dart';
import 'package:aqua_task/views/screens/home/widgets/home_add_leave_button_widget.dart';

import 'package:aqua_task/views/screens/home/widgets/home_add_leave_date_widget.dart';
import 'package:aqua_task/views/screens/home/widgets/home_add_leave_dropdown_reason_widget.dart';
import 'package:aqua_task/views/screens/home/widgets/home_add_leave_name_widget.dart';
import 'package:aqua_task/views/screens/home/widgets/home_add_leave_reason_widget.dart';
import 'package:aqua_task/views/screens/home/widgets/home_add_leave_select_date_widget.dart';

class HomeAddLeaveBottomSheetWidget extends StatelessWidget {
  const HomeAddLeaveBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HomeAddLeaveNameWidget(),
            SizedBox(height: 12),
            HomeAddLeaveReasonWidget(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HomeAddLeaveDateWidget(),
                HomeAddLeaveSelectDateWidget(),
              ],
            ),
            HomeAddLeaveDropdownReasonWidget(),
            SizedBox(height: 16),
            HomeAddLeaveButtonWidget(),
          ],
        ),
      ),
    );
  }
}

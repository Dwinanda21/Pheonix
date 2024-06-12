import 'package:flutter/material.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:aqua_task/views/screens/home/widgets/home_add_leave_bottom_sheet_widget.dart';
import 'package:aqua_task/views/screens/home/widgets/home_add_leave_limit_widget.dart';
import 'package:aqua_task/views/screens/home/widgets/home_app_bar_widget.dart';
import 'package:aqua_task/views/screens/home/widgets/home_list_leave_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const HomeAddLeaveBottomSheetWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAppBarWidget(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HomeAddLeaveLimitWidget(),
                  TextButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Ajukan Cuti',
                          style: TextStyleConstant.captionLarge,
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.note_add,
                          color: ColorConstant.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const HomeListLeaveWidget(),
            ],
          ),
        ),
      )),
    );
  }
}

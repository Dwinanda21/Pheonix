import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:aqua_task/view_models/home_view_model.dart';

class HomeAddLeaveSelectDateWidget extends StatelessWidget {
  const HomeAddLeaveSelectDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel =
        Get.put(HomeViewModel(), permanent: true);

    return Obx(
      () => IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              contentPadding: const EdgeInsets.all(16.0),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: TableCalendar(
                        locale: 'id_ID',
                        focusedDay:
                            homeViewModel.startDate.value ?? DateTime.now(),
                        firstDay: DateTime.now(),
                        lastDay: DateTime(DateTime.now().year + 1),
                        calendarFormat: CalendarFormat.month,
                        rangeSelectionMode:
                            homeViewModel.rangeSelectionMode.value,
                        selectedDayPredicate: (day) {
                          return isSameDay(
                                  homeViewModel.selectedStartDate.value, day) ||
                              isSameDay(
                                  homeViewModel.selectedEndDate.value, day);
                        },
                        onRangeSelected: (start, end, focusedDay) {
                          homeViewModel.onRangeSelected(start, end, focusedDay);
                          homeViewModel.rangeSelectionMode.value =
                              RangeSelectionMode.toggledOn;
                        },
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          todayDecoration: BoxDecoration(
                            color: ColorConstant.secondary.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: const BoxDecoration(
                            color: ColorConstant.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                          titleTextStyle: TextStyleConstant.titleSmall,
                          leftChevronIcon: const Icon(Icons.chevron_left,
                              color: ColorConstant.black),
                          rightChevronIcon: const Icon(Icons.chevron_right,
                              color: ColorConstant.black),
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(color: ColorConstant.black),
                          weekendStyle:
                              TextStyle(color: ColorConstant.errorFocused),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Batal',
                    style: TextStyleConstant.captionLarge.copyWith(
                      color: ColorConstant.errorFocused,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyleConstant.captionLarge
                        .copyWith(color: ColorConstant.primary),
                  ),
                )
              ],
            ),
          );
        },
        icon: Icon(
          Icons.calendar_month,
          color: homeViewModel.selectedStartDate.value != null &&
                  homeViewModel.selectedEndDate.value != null
              ? ColorConstant.primary
              : ColorConstant.secondary,
        ),
      ),
    );
  }
}

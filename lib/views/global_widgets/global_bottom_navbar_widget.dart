import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/view_models/global_bottom_navbar_view_model.dart';
import 'package:aqua_task/views/screens/coming_soon/coming_soon_screen.dart';
import 'package:aqua_task/views/screens/home/home_screen.dart';

import 'package:aqua_task/constant/text_style_constant.dart';

class GlobalBottomNavbarWidget extends StatelessWidget {
  const GlobalBottomNavbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalBottomNavbarViewModel globalBottomNavbarViewModel =
        Get.put(GlobalBottomNavbarViewModel());
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: globalBottomNavbarViewModel.currentIndex.value,
          children: const [
            HomeScreen(),
            ComingSoonScreen(),
            ComingSoonScreen(),
            ComingSoonScreen(),
            ComingSoonScreen(),
          ],
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Obx(() {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyleConstant.captionMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorConstant.background2Color,
            ),
            unselectedLabelStyle: TextStyleConstant.captionMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorConstant.background2Color,
            ),
            backgroundColor: ColorConstant.primary,
            currentIndex: globalBottomNavbarViewModel.currentIndex.value,
            onTap: (index) {
              globalBottomNavbarViewModel.setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: ColorConstant.background2Color,
                ),
                label: 'Beranda',
                activeIcon: Icon(
                  Icons.home_rounded,
                  color: ColorConstant.background2Color,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.note_alt_outlined,
                  color: ColorConstant.background2Color,
                ),
                label: 'Persetujuan',
                activeIcon: Icon(
                  Icons.note_alt_rounded,
                  color: ColorConstant.background2Color,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.note_add_outlined,
                  color: ColorConstant.background2Color,
                ),
                label: 'Pengajuan',
                activeIcon: Icon(
                  Icons.note_add_rounded,
                  color: ColorConstant.background2Color,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history_outlined,
                  color: ColorConstant.background2Color,
                ),
                label: 'Riwayat',
                activeIcon: Icon(
                  Icons.history_rounded,
                  color: ColorConstant.background2Color,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month_outlined,
                  color: ColorConstant.background2Color,
                ),
                label: 'Kalender',
                activeIcon: Icon(
                  Icons.calendar_month_rounded,
                  color: ColorConstant.background2Color,
                ),
              ),
            ],
            selectedItemColor: ColorConstant.background2Color,
            unselectedItemColor:
                ColorConstant.background2Color.withOpacity(0.6),
          );
        }),
      ),
    );
  }
}

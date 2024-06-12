import 'package:flutter/material.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'SEGERA HADIR',
              style: TextStyleConstant.titleLarge.copyWith(
                color: ColorConstant.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Fitur ini masih dalam tahap pengembangan. Tunggu kabar selanjutnya ya!',
              style: TextStyleConstant.bodyMedium,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

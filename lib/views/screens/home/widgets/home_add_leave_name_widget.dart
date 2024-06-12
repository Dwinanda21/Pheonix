import 'package:flutter/material.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:aqua_task/helpers/shared_pref_helper.dart';

class HomeAddLeaveNameWidget extends StatelessWidget {
  const HomeAddLeaveNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: SharedPrefHelper.getUsername(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final savedUsername = snapshot.data ?? 'Unknown User';
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: Text(
                  'Nama: ',
                  style: TextStyleConstant.bodyLarge.copyWith(
                    color: ColorConstant.black.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 6,
                child: Text(
                  savedUsername,
                  style: TextStyleConstant.bodyLarge.copyWith(
                    color: ColorConstant.black,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

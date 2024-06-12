import 'package:flutter/material.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:loading_indicator/loading_indicator.dart';

class GlobalFormButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isFormValid;
  final bool isLoading;

  const GlobalFormButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.isLoading,
    this.isFormValid = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isFormValid ? onTap : null,
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isFormValid
              ? ColorConstant.primary
              : ColorConstant.primary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: 20,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballBeat,
                    strokeWidth: 4.0,
                    colors: [Theme.of(context).secondaryHeaderColor],
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyleConstant.bodyLarge.copyWith(
                  color: isFormValid
                      ? Colors.white
                      : ColorConstant.backgroundColor,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}

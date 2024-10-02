import 'package:flutter/material.dart';

import '../misc/constant.dart';

enum ButtonLoadingStyleType { filled, outlined }

class ButtonLoading extends StatelessWidget {
  const ButtonLoading.filled({
    super.key,
    this.style = ButtonLoadingStyleType.filled,
    this.color = AppColors.primaryColor,
    this.iconColor = Colors.white,
    this.width = double.infinity,
    this.height = 44.0,
    this.borderRadius = 20.0,
    this.disabled = false,
  });

  const ButtonLoading.outlined({
    super.key,
    this.style = ButtonLoadingStyleType.outlined,
    this.color = Colors.transparent,
    this.iconColor = AppColors.primaryColor,
    this.width = double.infinity,
    this.height = 44.0,
    this.borderRadius = 20.0,
    this.disabled = false,
  });

  final ButtonLoadingStyleType style;
  final Color color;
  final Color iconColor;
  final double? width;
  final double height;
  final double borderRadius;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: style == ButtonLoadingStyleType.filled
          ? ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: CircularProgressIndicator(color: iconColor),
            )
          : OutlinedButton(
              onPressed: null,
              style: OutlinedButton.styleFrom(
                backgroundColor: color,
                side: BorderSide(color: iconColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: CircularProgressIndicator(color: iconColor),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/core/resources/font_manager.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isVisible;

  const SkipButton({
    super.key,
    required this.onPressed,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              "تخطي",
              style: TextStyle(
                color: ColorManager.appColor,
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

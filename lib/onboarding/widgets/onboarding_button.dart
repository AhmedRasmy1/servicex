import 'package:flutter/material.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/core/resources/font_manager.dart';

class OnboardingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const OnboardingButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.appColor,
            foregroundColor: ColorManager.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
          ),
          child: Text(text, style: TextStyle(fontSize: FontSize.s20)),
        ),
      ),
    );
  }
}

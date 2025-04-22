import 'package:flutter/material.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/core/resources/font_manager.dart';

class TextOnBrodingTitle extends StatelessWidget {
  const TextOnBrodingTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: FontSize.s26,
          color: ColorManager.appColor,
          fontWeight: FontWeightManager.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

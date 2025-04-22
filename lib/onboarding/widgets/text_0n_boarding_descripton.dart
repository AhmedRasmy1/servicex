import 'package:flutter/material.dart';
import 'package:servicex/core/resources/color_manager.dart';

class TextOnBoardingDescripton extends StatelessWidget {
  const TextOnBoardingDescripton({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        description,
        style: TextStyle(fontSize: 18, color: ColorManager.black, height: 1.5),
        textAlign: TextAlign.center,
      ),
    );
  }
}

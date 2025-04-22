import 'package:flutter/material.dart';
import 'package:servicex/onboarding/widgets/text_0n_boarding_descripton.dart';
import 'package:servicex/onboarding/widgets/text_on_broding_title.dart';

class OnboardingCard extends StatelessWidget {
  final String image, title, description;

  const OnboardingCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300),
        SizedBox(height: 30),
        TextOnBrodingTitle(title: title),
        SizedBox(height: 20),
        TextOnBoardingDescripton(description: description),
      ],
    );
  }
}

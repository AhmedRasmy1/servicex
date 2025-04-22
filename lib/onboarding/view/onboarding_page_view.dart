import 'package:flutter/material.dart';
import 'package:servicex/onboarding/widgets/onboarding_card.dart';
import '../data/onboarding_data.dart';

class OnboardingPageView extends StatelessWidget {
  final PageController controller;
  final Function(int) onPageChanged;

  const OnboardingPageView({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: onboardingData.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        final data = onboardingData[index];
        return OnboardingCard(
          image: data['image']!,
          title: data['title']!,
          description: data['description']!,
        );
      },
    );
  }
}

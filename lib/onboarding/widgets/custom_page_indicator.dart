import 'package:flutter/material.dart';
import 'package:servicex/onboarding/data/onboarding_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageIndicator extends StatelessWidget {
  const CustomPageIndicator({super.key, required PageController pageController})
    : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _pageController,
      count: onboardingData.length,
      onDotClicked: (index) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      effect: ExpandingDotsEffect(
        dotHeight: 12,
        dotWidth: 12,
        spacing: 8,
        expansionFactor: 3,
        activeDotColor: const Color(0xFF0054A5),
        dotColor: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}

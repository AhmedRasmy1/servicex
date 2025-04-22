import 'package:flutter/material.dart';
import 'package:servicex/core/resources/color_manager.dart';
import 'package:servicex/onboarding/view/onboarding_page_view.dart';
import 'package:servicex/onboarding/widgets/custom_page_indicator.dart';
import '../../login/view/login_view.dart';
import '../data/onboarding_data.dart';
import '../widgets/skip_button.dart';
import '../widgets/onboarding_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _navigateToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _onNextPressed() {
    if (_currentPage < onboardingData.length - 1) {
      _navigateToNextPage();
    } else {
      _navigateToLoginPage();
    }
  }

  void _skipToLastPage() {
    _pageController.animateToPage(
      onboardingData.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  String _getButtonText() {
    if (_currentPage == 0) return "ابدأ";
    if (_currentPage == onboardingData.length - 1) return "ابدأ الآن";
    return "التالي";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: Column(
          children: [
            SkipButton(
              isVisible: _currentPage != onboardingData.length - 1,
              onPressed: _skipToLastPage,
            ),
            Expanded(
              child: OnboardingPageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
              ),
            ),
            CustomPageIndicator(pageController: _pageController),
            const SizedBox(height: 30),
            OnboardingButton(onPressed: _onNextPressed, text: _getButtonText()),
          ],
        ),
      ),
    );
  }
}

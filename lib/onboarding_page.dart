import 'package:flutter/material.dart';
import 'package:servicex/core/resources/assets_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController nextPage = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": AssetsManager.onBoardingImageone,
      "title": "مرحبا بك في سرفيس اكس",
      "description":
          "اكتشف سيرفكس اكس ، الحل الوحيد الذي يجمع بين الراحة والموثوقية لجميع احتياجاتك في خدمات الصيانة المنزلية",
    },
    {
      "image": AssetsManager.onBoardingImagetwo,
      "title": "اكتشف خدمات جديدة",
      "description":
          "تصفح واحجز من مجموعة واسعة من الخدمات. من الكهرباء والسباكة إلى صيانة الأجهزة... إحنا مغطين كل شيء",
    },
    {
      "image": AssetsManager.onBoardingImagethree,
      "title": "كل خدمات الصيانة في مكان واحد",
      "description":
          "كل اللي تحتاجه من كهرباء لسباكة وصيانة أجهزة هتلاقيه هنا في سيرفس اكس",
    },
  ];

  Widget dotPageView() {
    return SmoothPageIndicator(
      onDotClicked: (index) {
        nextPage.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      controller: nextPage,
      count: onboardingData.length,
      effect: ExpandingDotsEffect(
        dotHeight: 12,
        dotWidth: 12,
        activeDotColor: const Color(0xFF0054A5),
        dotColor: Colors.grey.withOpacity(0.5),
        spacing: 8,
        expansionFactor: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0054A5), Color(0xFF87CEEB)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Opacity(
                opacity: currentPage != onboardingData.length - 1 ? 1.0 : 0.0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      onPressed:
                          currentPage != onboardingData.length - 1
                              ? () {
                                nextPage.animateToPage(
                                  onboardingData.length - 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                              : null,
                      child: const Text(
                        "تخطي",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: nextPage,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          onboardingData[index]['image']!,
                          height: 300,
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            onboardingData[index]['title']!,
                            style: const TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            onboardingData[index]['description']!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              dotPageView(),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentPage < onboardingData.length - 1) {
                        nextPage.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Navigator.pushReplacement(...);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0054A5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      currentPage == 0
                          ? "ابدأ"
                          : currentPage == onboardingData.length - 1
                          ? "ابدأ الآن"
                          : "التالي",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

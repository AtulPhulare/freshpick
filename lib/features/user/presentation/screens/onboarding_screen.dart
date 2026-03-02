import 'package:flutter/material.dart';
import 'package:freshpick/core/constants/app_colors.dart';
import 'package:freshpick/config/routes/app_routes.dart';
import 'package:freshpick/core/common/common_button.dart';
import '../widgets/onboarding_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlideData> _slides = [
    OnboardingSlideData(
      title: 'Fresh From Farm',
      description:
          'Get the freshest fruits and vegetables delivered directly from local farms to your kitchen.',
      icon: Icons.eco_rounded,
      color: AppColors.primary,
    ),
    OnboardingSlideData(
      title: 'Quick Delivery',
      description:
          'Experience lightning-fast delivery to your doorstep in under 30 minutes, keeping your produce fresh.',
      icon: Icons.delivery_dining_rounded,
      color: AppColors.accent,
    ),
    OnboardingSlideData(
      title: 'Quality Guaranteed',
      description:
          'We ensure the best quality produce with our strict 100% quality check process for every item.',
      icon: Icons.verified_user_rounded,
      color: AppColors.warning,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.phoneLogin,
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingSlide(data: _slides[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => _buildIndicator(index == _currentPage),
                    ),
                  ),
                  const SizedBox(height: 48),
                  CommonButton(
                    text: _currentPage == _slides.length - 1
                        ? 'Get Started'
                        : 'Next',
                    onPressed: () {
                      if (_currentPage < _slides.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.phoneLogin,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.background,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

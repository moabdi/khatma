import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma_ui/khatma_ui.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLastPage = false;
  double _progressValue = 0.0;

  List<OnboardingItem> _onboardingItems(context) => [
        OnboardingItem(
          lottieAsset: 'assets/lottie/complete_parts.json',
          title: AppLocalizations.of(context).onboarding1Title,
          description: AppLocalizations.of(context).onboarding1Description,
          bgColor: Colors.transparent,
        ),
        OnboardingItem(
          lottieAsset: 'assets/lottie/group.json',
          title: AppLocalizations.of(context).onboarding2Title,
          description: AppLocalizations.of(context).onboarding2Description,
          bgColor: Colors.transparent,
        ),
        OnboardingItem(
          lottieAsset: 'assets/lottie/kpi.json',
          title: AppLocalizations.of(context).onboarding3Title,
          description: AppLocalizations.of(context).onboarding3Description,
          bgColor: Colors.transparent,
        ),
        OnboardingItem(
          lottieAsset: 'assets/lottie/reading.json',
          title: AppLocalizations.of(context).onboarding4Title,
          description: AppLocalizations.of(context).onboarding4Description,
          bgColor: Colors.transparent,
        ),
      ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_updateProgress);
  }

  void _updateProgress() {
    setState(() {
      _currentPage = _pageController.page?.round() ?? 0;
      _isLastPage = _currentPage == _onboardingItems(context).length - 1;
      _progressValue =
          (_pageController.page ?? 0) / (_onboardingItems(context).length - 1);
    });
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    context.goNamed(AppRoute.khatma.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: _onboardingItems(context)[_currentPage].bgColor,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _onboardingItems(context).length,
                      itemBuilder: (context, index) {
                        return _buildOnboardingPage(
                            _onboardingItems(context)[index]);
                      },
                    ),
                  ),
                  _buildBottomControls(),
                ],
              ),
              _buildDecorativeElements(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie Animation
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Lottie.asset(
              item.lottieAsset,
              fit: BoxFit.contain,
              repeat: false,
            ),
          ),

          gapH12,

          // Title with Fade Animation
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Text(
              item.title,
              key: ValueKey(item.title),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),

          SizedBox(height: 16),

          // Description with Slide Animation
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            child: Text(
              item.description,
              key: ValueKey(item.description),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
      child: Column(
        children: [
          // Page Indicator
          SmoothPageIndicator(
            controller: _pageController,
            count: _onboardingItems(context).length,
            effect: ExpandingDotsEffect(
              activeDotColor: context.colorScheme.primary,
              dotColor: context.theme.disabledColor,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 8,
              expansionFactor: 3,
            ),
          ),

          SizedBox(height: 32),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLastPage
                  ? _completeOnboarding
                  : () => _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOutCubic,
                      ),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(
                  _isLastPage
                      ? AppLocalizations.of(context).startButton
                      : AppLocalizations.of(context).continueButton,
                  key: ValueKey(_isLastPage ? 'start' : 'continue'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeElements() {
    return IgnorePointer(
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Opacity(
              opacity: 0.1,
              child: SvgPicture.asset(
                'assets/images/splash.svg',
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String lottieAsset;
  final String title;
  final String description;
  final Color bgColor;

  OnboardingItem({
    required this.lottieAsset,
    required this.title,
    required this.description,
    required this.bgColor,
  });
}

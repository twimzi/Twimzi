import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/services/app_preferences.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_card.dart';
import '../widgets/page_indicator.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    await AppPreferences.setFirstLaunchCompleted();

    if (!mounted) return;

    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final pages = ref.watch(onboardingPagesProvider);
    final currentPage = ref.watch(onboardingPageProvider);

    final isLastPage = currentPage == pages.length - 1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: _finishOnboarding,
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  ref.read(onboardingPageProvider.notifier).state = index;
                },
                itemBuilder: (context, index) {
                  return OnboardingCard(
                    item: pages[index],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PageIndicator(
                currentIndex: currentPage,
                totalPages: pages.length,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(
                text: isLastPage ? 'Get Started' : 'Next',
                onPressed: () async {
                  if (isLastPage) {
                    await _finishOnboarding();
                    return;
                  }

                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
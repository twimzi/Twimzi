import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/onboarding_model.dart';

final onboardingPagesProvider = Provider<List<OnboardingModel>>((ref) {
  return const [
    OnboardingModel(
      title: 'Discover Everything Around You',
      subtitle:
      'Find local businesses, products, services and exclusive offers in your city with one powerful app.',
      image: 'assets/images/onboarding/onboarding_1.png',
    ),
    OnboardingModel(
      title: 'Grow Your Business Digitally',
      subtitle:
      'Create your digital business profile, showcase products and services, and connect directly with customers.',
      image: 'assets/images/onboarding/onboarding_2.png',
    ),
    OnboardingModel(
      title: 'One Platform. Endless Possibilities.',
      subtitle:
      'Search, chat, explore and grow with the Digital Operating System for Every Local Business.',
      image: 'assets/images/onboarding/onboarding_3.png',
    ),
  ];
});

final onboardingPageProvider = StateProvider<int>((ref) => 0);
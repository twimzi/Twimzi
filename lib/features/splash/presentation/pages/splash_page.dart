import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/services/app_preferences.dart';
import '../widgets/animated_logo.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted || _navigated) return;

    _navigated = true;

    final firstLaunch = await AppPreferences.isFirstLaunch();

    if (!mounted) return;

    if (firstLaunch) {
      context.go(AppRoutes.onboarding);
    } else {
      // Change this to AppRoutes.welcome after Welcome screen is added.
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: AnimatedLogo(
              size: 220,
            ),
          ),
        ),
      ),
    );
  }
}
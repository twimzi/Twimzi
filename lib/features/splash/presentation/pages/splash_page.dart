import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/services/app_preferences.dart';
import '../../../../core/widgets/feedback/loading_indicator.dart';
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
      // Later this will check authentication.
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedLogo(size: 160),

                    SizedBox(height: 30),

                    Text(
                      'Twimzi',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 14),

                    Text(
                      'Digital Operating System\nfor Every Local Business',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              child: Center(
                child: TwimziLoadingIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
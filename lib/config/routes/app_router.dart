import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
}

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) {
        return const OnboardingPage();
      },
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) {
        return const RegisterPage();
      },
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      name: 'forgotPassword',
      builder: (context, state) {
        return const ForgotPasswordPage();
      },
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
  ],
);
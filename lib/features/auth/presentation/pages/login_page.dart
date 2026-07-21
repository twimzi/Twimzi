import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_footer.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(
      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 6) {
      return 'Password must contain at least 6 characters';
    }

    return null;
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(authProvider.notifier).signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    final authState = ref.read(authProvider);

    if (authState.isAuthenticated && mounted) {
      context.go(AppRoutes.home);
      return;
    }

    if (authState.hasError && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authState.errorMessage ?? 'Login failed',
          ),
        ),
      );
    }
  }

  Future<void> _googleSignIn() async {
    await ref.read(authProvider.notifier).signInWithGoogle();

    final authState = ref.read(authProvider);

    if (authState.isAuthenticated && mounted) {
      context.go(AppRoutes.home);
      return;
    }

    if (authState.hasError && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authState.errorMessage ?? 'Google Sign-In failed',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),

                const AuthHeader(
                  title: 'Welcome Back',
                  subtitle: 'Sign in to continue using Twimzi.',
                ),

                const SizedBox(height: 40),

                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: _emailValidator,
                ),

                const SizedBox(height: 20),

                PasswordField(
                  controller: _passwordController,
                  validator: _passwordValidator,
                ),

                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.go(AppRoutes.forgotPassword);
                    },
                    child: const Text(
                      'Forgot Password?',
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                PrimaryButton(
                  text: authState.isLoading
                      ? 'Signing In...'
                      : 'Login',
                  onPressed: authState.isLoading
                      ? null
                      : _login,
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    const Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Text(
                        'OR',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),
                    ),
                    const Expanded(
                      child: Divider(),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                OutlinedButton.icon(
                  onPressed: authState.isLoading
                      ? null
                      : _googleSignIn,
                  icon: const Icon(
                    Icons.g_mobiledata,
                  ),
                  label: const Text(
                    'Continue with Google',
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                ),

                const SizedBox(height: 24),

                AuthFooter(
                  text: "Don't have an account?",
                  buttonText: "Register",
                  onPressed: () {
                    context.go(AppRoutes.register);
                  },
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    context.go(AppRoutes.home);
                  },
                  child: const Text(
                    'Continue as Guest',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
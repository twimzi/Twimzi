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

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _required(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex =
    RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Minimum 6 characters';
    }

    return null;
  }

  String? _confirmValidator(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(authProvider.notifier).register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    final state = ref.read(authProvider);

    if (!mounted) return;

    if (state.isAuthenticated) {
      context.go(AppRoutes.home);
      return;
    }

    if (state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.errorMessage ?? 'Registration failed',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const AuthHeader(
                  title: 'Create Account',
                  subtitle:
                  'Register your Twimzi account.',
                ),

                const SizedBox(height: 32),

                AuthTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  validator: (v) => _required(v, 'Name'),
                ),

                const SizedBox(height: 16),

                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: _emailValidator,
                ),

                const SizedBox(height: 16),

                PasswordField(
                  controller: _passwordController,
                  validator: _passwordValidator,
                ),

                const SizedBox(height: 16),

                PasswordField(
                  controller: _confirmPasswordController,
                  validator: _confirmValidator,
                ),

                const SizedBox(height: 32),

                PrimaryButton(
                  text: authState.isLoading
                      ? 'Creating Account...'
                      : 'Create Account',
                  onPressed: authState.isLoading
                      ? null
                      : _register,
                ),

                const SizedBox(height: 24),

                AuthFooter(
                  text: 'Already have an account?',
                  buttonText: 'Login',
                  onPressed: () {
                    context.go(AppRoutes.login);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_header.dart';

class EmailVerificationPage extends ConsumerStatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  ConsumerState<EmailVerificationPage> createState() =>
      _EmailVerificationPageState();
}

class _EmailVerificationPageState
    extends ConsumerState<EmailVerificationPage> {
  bool _checking = false;

  Future<void> _checkVerification() async {
    setState(() {
      _checking = true;
    });

    try {
      final verified = await ref
          .read(authProvider.notifier)
          .checkEmailVerification();

      if (!mounted) return;

      if (verified) {
        context.go(AppRoutes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Your email is not verified yet.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _checking = false;
        });
      }
    }
  }

  Future<void> _resendVerification() async {
    await ref
        .read(authProvider.notifier)
        .resendVerificationEmail();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Verification email sent successfully.',
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await ref.read(authProvider.notifier).signOut();

    if (!mounted) return;

    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.mark_email_read_outlined,
                  size: 100,
                ),

                const SizedBox(height: 32),

                const AuthHeader(
                  title: 'Verify Your Email',
                  subtitle:
                  'We have sent a verification link to your registered email address.',
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Registered Email',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        authState.email ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                PrimaryButton(
                  text: _checking
                      ? 'Checking...'
                      : "I've Verified My Email",
                  onPressed:
                  _checking ? null : _checkVerification,
                ),

                const SizedBox(height: 16),

                OutlinedButton(
                  onPressed: _resendVerification,
                  child: const Text(
                    'Resend Verification Email',
                  ),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    context.go(AppRoutes.register);
                  },
                  child: const Text(
                    'Change Email Address',
                  ),
                ),

                const SizedBox(height: 24),

                TextButton.icon(
                  onPressed: _logout,
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    'Logout',
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
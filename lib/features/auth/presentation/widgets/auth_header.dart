import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FlutterLogo(size: 80),

        const SizedBox(height: 24),

        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        const SizedBox(height: 8),

        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
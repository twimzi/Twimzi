import 'package:flutter/material.dart';

import '../../domain/onboarding_model.dart';

class OnboardingCard extends StatelessWidget {
  const OnboardingCard({
    super.key,
    required this.item,
  });

  final OnboardingModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Center(
              child: Image.asset(
                item.image,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) {
                  return Icon(
                    Icons.image_outlined,
                    size: 140,
                    color: theme.colorScheme.primary,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            item.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            item.subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
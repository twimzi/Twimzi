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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const Spacer(),

            Expanded(
              flex: 6,
              child: Hero(
                tag: item.image,
                child: Image.asset(
                  item.image,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.image_outlined,
                    size: 140,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            Text(
              item.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                item.subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.6,
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

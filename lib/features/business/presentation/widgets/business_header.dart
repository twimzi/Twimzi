import 'package:flutter/material.dart';

import '../../data/models/business_identity.dart';

class BusinessHeader extends StatelessWidget {
  const BusinessHeader({
    super.key,
    required this.business,
    this.showCompletion = false,
    this.onEdit,
  });

  final BusinessIdentity business;
  final bool showCompletion;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 45,
              child: Text(
                business.name.isEmpty
                    ? 'B'
                    : business.name.characters.first.toUpperCase(),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    business.name,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                if (business.verification.verifiedBusiness) ...[
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 20,
                  ),
                ],
              ],
            ),

            if (business.handle.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                '@${business.handle}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],

            if (business.tagline.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                business.tagline,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ],

            if (showCompletion) ...[
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: business.profileCompletion / 100,
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${business.profileCompletion}%',
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile Completion',
                  style: theme.textTheme.bodySmall,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Edit Business'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../data/models/business_identity.dart';

class BusinessModulesCard extends StatelessWidget {
  final BusinessIdentity business;

  const BusinessModulesCard({
    super.key,
    required this.business,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enabled Modules',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: business.modules
                  .where((m) => m.enabled)
                  .map(
                    (module) => Chip(
                  label: Text(module.name),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
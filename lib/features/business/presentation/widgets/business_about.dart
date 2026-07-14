import 'package:flutter/material.dart';

import '../../data/models/business_identity.dart';

class BusinessAbout extends StatelessWidget {
  final BusinessIdentity business;

  const BusinessAbout({
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
              'About',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(business.description),
          ],
        ),
      ),
    );
  }
}
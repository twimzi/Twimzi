import 'package:flutter/material.dart';

import '../../data/models/business_identity.dart';

class BusinessHeader extends StatelessWidget {
  final BusinessIdentity business;

  const BusinessHeader({
    super.key,
    required this.business,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          child: Text(
            business.name.characters.first,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          business.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          business.tagline,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
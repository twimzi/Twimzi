import 'package:flutter/material.dart';

import '../../data/models/business_identity.dart';

class BusinessContactCard extends StatelessWidget {
  final BusinessIdentity business;

  const BusinessContactCard({
    super.key,
    required this.business,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(business.contact.phone),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(business.contact.email),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(business.contact.website),
            ),
          ],
        ),
      ),
    );
  }
}
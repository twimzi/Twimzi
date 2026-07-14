import 'package:flutter/material.dart';

import '../../data/models/business_identity.dart';

class BusinessVerificationCard extends StatelessWidget {
  final BusinessIdentity business;

  const BusinessVerificationCard({
    super.key,
    required this.business,
  });

  Widget _item(
      String title,
      bool value,
      ) {
    return Row(
      children: [
        Icon(
          value ? Icons.check_circle : Icons.cancel,
          color: value ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 10),
        Text(title),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final v = business.verification;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            _item('Verified Business', v.verifiedBusiness),

            const SizedBox(height: 12),

            _item('Phone Verified', v.phoneVerified),

            const SizedBox(height: 12),

            _item('Email Verified', v.emailVerified),

            const SizedBox(height: 12),

            _item('Address Verified', v.addressVerified),

            const SizedBox(height: 12),

            _item('GST Verified', v.gstVerified),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../data/models/business_identity.dart';

class BusinessWorkingHours extends StatelessWidget {
  final BusinessIdentity business;

  const BusinessWorkingHours({
    super.key,
    required this.business,
  });

  Widget row(String day, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(day),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = business.hours;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Working Hours',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            row('Monday', h.monday),
            row('Tuesday', h.tuesday),
            row('Wednesday', h.wednesday),
            row('Thursday', h.thursday),
            row('Friday', h.friday),
            row('Saturday', h.saturday),
            row('Sunday', h.sunday),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'business_card.dart';
import 'section_title.dart';

class NearbyBusinesses extends StatelessWidget {
  const NearbyBusinesses({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionTitle(title: 'Nearby Businesses'),
        SizedBox(height: 12),
        BusinessCard(
          name: 'Singh Auto Parts',
          category: 'Automobile',
          location: '500 m',
        ),
        BusinessCard(
          name: 'Royal Salon',
          category: 'Salon',
          location: '850 m',
        ),
        BusinessCard(
          name: 'Green Pharmacy',
          category: 'Medical',
          location: '1.2 km',
        ),
      ],
    );
  }
}
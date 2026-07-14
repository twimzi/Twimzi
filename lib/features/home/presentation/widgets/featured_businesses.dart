import 'package:flutter/material.dart';

import 'business_card.dart';
import 'section_title.dart';

class FeaturedBusinesses extends StatelessWidget {
  const FeaturedBusinesses({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionTitle(title: 'Popular Businesses'),
        SizedBox(height: 12),
        BusinessCard(
          name: 'ABC Electronics',
          category: 'Electronics',
          location: 'Ludhiana',
        ),
        BusinessCard(
          name: 'Punjab Fast Food',
          category: 'Restaurant',
          location: 'Ludhiana',
        ),
        BusinessCard(
          name: 'City Gym',
          category: 'Fitness',
          location: 'Ludhiana',
        ),
      ],
    );
  }
}
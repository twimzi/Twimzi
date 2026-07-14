import 'package:flutter/material.dart';

import 'business_card.dart';
import 'section_title.dart';

class NewBusinesses extends StatelessWidget {
  const NewBusinesses({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionTitle(title: 'Newly Joined'),
        SizedBox(height: 12),
        BusinessCard(
          name: 'Modern Furniture',
          category: 'Furniture',
          location: 'Ludhiana',
        ),
        BusinessCard(
          name: 'Cake Studio',
          category: 'Bakery',
          location: 'Ludhiana',
        ),
      ],
    );
  }
}
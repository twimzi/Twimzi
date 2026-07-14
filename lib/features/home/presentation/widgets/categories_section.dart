import 'package:flutter/material.dart';

import 'category_card.dart';
import 'section_title.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: 'Categories'),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              CategoryCard(icon: Icons.store, title: 'Business'),
              CategoryCard(icon: Icons.shopping_bag, title: 'Products'),
              CategoryCard(icon: Icons.design_services, title: 'Services'),
              CategoryCard(icon: Icons.local_offer, title: 'Offers'),
              CategoryCard(icon: Icons.event, title: 'Events'),
              CategoryCard(icon: Icons.work, title: 'Jobs'),
            ],
          ),
        ),
      ],
    );
  }
}
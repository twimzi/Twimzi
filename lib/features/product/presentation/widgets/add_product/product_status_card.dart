
import 'package:flutter/material.dart';

class ProductStatusCard extends StatelessWidget {
  const ProductStatusCard({
    super.key,
    required this.isFeatured,
    required this.isActive,
    required this.onFeaturedChanged,
    required this.onActiveChanged,
  });

  final bool isFeatured;
  final bool isActive;
  final ValueChanged<bool> onFeaturedChanged;
  final ValueChanged<bool> onActiveChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Status',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Featured Product'),
              subtitle: const Text(
                'Display this product as featured.',
              ),
              value: isFeatured,
              onChanged: onFeaturedChanged,
            ),
            const Divider(),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Active'),
              subtitle: const Text(
                'Inactive products are hidden from customers.',
              ),
              value: isActive,
              onChanged: onActiveChanged,
            ),
          ],
        ),
      ),
    );
  }
}

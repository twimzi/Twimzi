import 'package:flutter/material.dart';

class DashboardStatistics extends StatelessWidget {
  const DashboardStatistics({
    super.key,
    required this.profileViews,
    required this.products,
    required this.services,
    required this.followers,
  });

  final int profileViews;
  final int products;
  final int services;
  final int followers;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        _StatisticCard(
          title: 'Profile Views',
          value: profileViews.toString(),
          icon: Icons.visibility_outlined,
        ),
        _StatisticCard(
          title: 'Products',
          value: products.toString(),
          icon: Icons.inventory_2_outlined,
        ),
        _StatisticCard(
          title: 'Services',
          value: services.toString(),
          icon: Icons.handyman_outlined,
        ),
        _StatisticCard(
          title: 'Followers',
          value: followers.toString(),
          icon: Icons.people_outline,
        ),
      ],
    );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
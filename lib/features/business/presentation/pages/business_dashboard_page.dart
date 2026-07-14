import 'package:flutter/material.dart';

class BusinessDashboardPage extends StatelessWidget {
  const BusinessDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
      title: 'Products',
      icon: Icons.inventory_2_outlined,
      ),
      (
      title: 'Services',
      icon: Icons.handyman_outlined,
      ),
      (
      title: 'Offers',
      icon: Icons.local_offer_outlined,
      ),
      (
      title: 'Gallery',
      icon: Icons.photo_library_outlined,
      ),
      (
      title: 'Orders',
      icon: Icons.shopping_cart_outlined,
      ),
      (
      title: 'Bookings',
      icon: Icons.calendar_month_outlined,
      ),
      (
      title: 'Community',
      icon: Icons.groups_outlined,
      ),
      (
      title: 'Analytics',
      icon: Icons.bar_chart_outlined,
      ),
      (
      title: 'Reviews',
      icon: Icons.star_outline,
      ),
      (
      title: 'Followers',
      icon: Icons.people_outline,
      ),
      (
      title: 'Settings',
      icon: Icons.settings_outlined,
      ),
      (
      title: 'Profile',
      icon: Icons.storefront_outlined,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final item = items[index];

            return Card(
              elevation: 2,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      size: 42,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      item.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
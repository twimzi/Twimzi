import 'package:flutter/material.dart';

class DashboardModules extends StatelessWidget {
  const DashboardModules({
    super.key,
    required this.onProducts,
    required this.onServices,
    required this.onOffers,
    required this.onGallery,
    required this.onOrders,
    required this.onBookings,
    required this.onCommunity,
    required this.onAnalytics,
    required this.onReviews,
    required this.onFollowers,
    required this.onVerification,
    required this.onSettings,
  });

  final VoidCallback onProducts;
  final VoidCallback onServices;
  final VoidCallback onOffers;
  final VoidCallback onGallery;
  final VoidCallback onOrders;
  final VoidCallback onBookings;
  final VoidCallback onCommunity;
  final VoidCallback onAnalytics;
  final VoidCallback onReviews;
  final VoidCallback onFollowers;
  final VoidCallback onVerification;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final modules = <_DashboardModule>[
      _DashboardModule(
        title: 'Products',
        icon: Icons.inventory_2_outlined,
        onTap: onProducts,
      ),
      _DashboardModule(
        title: 'Services',
        icon: Icons.handyman_outlined,
        onTap: onServices,
      ),
      _DashboardModule(
        title: 'Offers',
        icon: Icons.local_offer_outlined,
        onTap: onOffers,
      ),
      _DashboardModule(
        title: 'Gallery',
        icon: Icons.photo_library_outlined,
        onTap: onGallery,
      ),
      _DashboardModule(
        title: 'Orders',
        icon: Icons.shopping_bag_outlined,
        onTap: onOrders,
      ),
      _DashboardModule(
        title: 'Bookings',
        icon: Icons.calendar_month_outlined,
        onTap: onBookings,
      ),
      _DashboardModule(
        title: 'Community',
        icon: Icons.groups_outlined,
        onTap: onCommunity,
      ),
      _DashboardModule(
        title: 'Analytics',
        icon: Icons.bar_chart_outlined,
        onTap: onAnalytics,
      ),
      _DashboardModule(
        title: 'Reviews',
        icon: Icons.star_outline,
        onTap: onReviews,
      ),
      _DashboardModule(
        title: 'Followers',
        icon: Icons.people_outline,
        onTap: onFollowers,
      ),
      _DashboardModule(
        title: 'Verification',
        icon: Icons.verified_user_outlined,
        onTap: onVerification,
      ),
      _DashboardModule(
        title: 'Settings',
        icon: Icons.settings_outlined,
        onTap: onSettings,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Business Modules',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: modules.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final module = modules[index];

            return Card(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: module.onTap,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        child: Icon(module.icon),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        module.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _DashboardModule {
  const _DashboardModule({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
}
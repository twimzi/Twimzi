import 'package:flutter/material.dart';

import '../../data/models/business_identity.dart';
import '../widgets/business_header.dart';
import '../widgets/dashboard_modules.dart';
import '../widgets/dashboard_quick_actions.dart';
import '../widgets/dashboard_recent_activity.dart';
import '../widgets/dashboard_statistics.dart';

class BusinessDashboardPage extends StatelessWidget {
  const BusinessDashboardPage({
    super.key,
    required this.business,
  });

  final BusinessIdentity business;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Dashboard'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BusinessHeader(
                business: business,
                showCompletion: true,
                onEdit: () {
                  // TODO: Navigate to Edit Business
                },
              ),

              const SizedBox(height: 20),

              const DashboardStatistics(
                profileViews: 248,
                products: 18,
                services: 7,
                followers: 96,
              ),

              const SizedBox(height: 24),

              DashboardQuickActions(
                onAddProduct: () {
                  // TODO
                },
                onAddService: () {
                  // TODO
                },
                onCreateOffer: () {
                  // TODO
                },
                onUploadGallery: () {
                  // TODO
                },
                onShareBusiness: () {
                  // TODO
                },
                onViewProfile: () {
                  // TODO
                },
              ),

              const SizedBox(height: 24),

              DashboardModules(
                onProducts: () {},
                onServices: () {},
                onOffers: () {},
                onGallery: () {},
                onOrders: () {},
                onBookings: () {},
                onCommunity: () {},
                onAnalytics: () {},
                onReviews: () {},
                onFollowers: () {},
                onVerification: () {},
                onSettings: () {},
              ),

              const SizedBox(height: 24),

              DashboardRecentActivity(
                activities: [
                  DashboardActivity(
                    title: 'New Product Added',
                    description: 'Premium Rotavator Blade',
                    icon: Icons.inventory_2_outlined,
                    time: '5 min ago',
                  ),
                  DashboardActivity(
                    title: 'New Review',
                    description: '★★★★★ Excellent quality products.',
                    icon: Icons.star_outline,
                    time: '20 min ago',
                  ),
                  DashboardActivity(
                    title: 'Offer Published',
                    description: 'Summer Sale 15% OFF',
                    icon: Icons.local_offer_outlined,
                    time: '1 hour ago',
                  ),
                  DashboardActivity(
                    title: 'New Follower',
                    description: 'Raj Agriculture',
                    icon: Icons.people_outline,
                    time: '3 hours ago',
                  ),
                ],
                onViewAll: () {
                  // TODO
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class DashboardQuickActions extends StatelessWidget {
  const DashboardQuickActions({
    super.key,
    required this.onAddProduct,
    required this.onAddService,
    required this.onCreateOffer,
    required this.onUploadGallery,
    required this.onShareBusiness,
    required this.onViewProfile,
  });

  final VoidCallback onAddProduct;
  final VoidCallback onAddService;
  final VoidCallback onCreateOffer;
  final VoidCallback onUploadGallery;
  final VoidCallback onShareBusiness;
  final VoidCallback onViewProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.95,
          children: [
            _ActionTile(
              title: 'Add Product',
              icon: Icons.inventory_2_outlined,
              onTap: onAddProduct,
            ),
            _ActionTile(
              title: 'Add Service',
              icon: Icons.handyman_outlined,
              onTap: onAddService,
            ),
            _ActionTile(
              title: 'Create Offer',
              icon: Icons.local_offer_outlined,
              onTap: onCreateOffer,
            ),
            _ActionTile(
              title: 'Gallery',
              icon: Icons.photo_library_outlined,
              onTap: onUploadGallery,
            ),
            _ActionTile(
              title: 'Share',
              icon: Icons.share_outlined,
              onTap: onShareBusiness,
            ),
            _ActionTile(
              title: 'Public Profile',
              icon: Icons.public_outlined,
              onTap: onViewProfile,
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                child: Icon(icon),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
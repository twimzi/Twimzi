import 'package:flutter/material.dart';

class DashboardRecentActivity extends StatelessWidget {
  const DashboardRecentActivity({
    super.key,
    required this.activities,
    this.onViewAll,
  });

  final List<DashboardActivity> activities;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Recent Activity',
                style: theme.textTheme.titleLarge,
              ),
            ),
            if (onViewAll != null)
              TextButton(
                onPressed: onViewAll,
                child: const Text('View All'),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          child: activities.isEmpty
              ? const Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: Text('No recent activity available.'),
            ),
          )
              : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final activity = activities[index];

              return ListTile(
                leading: CircleAvatar(
                  child: Icon(activity.icon),
                ),
                title: Text(activity.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (activity.description.isNotEmpty)
                      Text(activity.description),
                    const SizedBox(height: 2),
                    Text(
                      activity.time,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                trailing: activity.showArrow
                    ? const Icon(Icons.chevron_right)
                    : null,
                onTap: activity.onTap,
              );
            },
          ),
        ),
      ],
    );
  }
}

class DashboardActivity {
  const DashboardActivity({
    required this.title,
    required this.description,
    required this.icon,
    required this.time,
    this.onTap,
    this.showArrow = true,
  });

  final String title;
  final String description;
  final IconData icon;
  final String time;
  final VoidCallback? onTap;
  final bool showArrow;
}
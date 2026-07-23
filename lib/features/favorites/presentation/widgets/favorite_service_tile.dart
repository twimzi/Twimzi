import 'package:flutter/material.dart';

import '../../domain/entities/favorite.dart';

class FavoriteServiceTile extends StatelessWidget {
  const FavoriteServiceTile({
    super.key,
    required this.favorite,
    this.onTap,
  });

  final Favorite favorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: theme.colorScheme.tertiaryContainer,
          child: Icon(
            Icons.design_services_outlined,
            color: theme.colorScheme.tertiary,
          ),
        ),
        title: Text(
          'Service',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          favorite.entityId,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall,
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
        ),
        onTap: onTap,
      ),
    );
  }
}
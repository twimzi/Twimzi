import 'package:flutter/material.dart';

import '../../domain/entities/favorite.dart';

class FavoriteProductTile extends StatelessWidget {
  const FavoriteProductTile({
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
          backgroundColor: theme.colorScheme.secondaryContainer,
          child: Icon(
            Icons.inventory_2_outlined,
            color: theme.colorScheme.secondary,
          ),
        ),
        title: Text(
          'Product',
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
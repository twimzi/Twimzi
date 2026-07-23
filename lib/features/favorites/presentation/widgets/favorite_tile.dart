import 'package:flutter/material.dart';

import '../../domain/entities/favorite.dart';
import 'favorite_business_tile.dart';
import 'favorite_product_tile.dart';
import 'favorite_service_tile.dart';

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({
    super.key,
    required this.favorite,
    this.onTap,
  });

  final Favorite favorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    switch (favorite.type) {
      case FavoriteType.business:
        return FavoriteBusinessTile(
          favorite: favorite,
          onTap: onTap,
        );

      case FavoriteType.product:
        return FavoriteProductTile(
          favorite: favorite,
          onTap: onTap,
        );

      case FavoriteType.service:
        return FavoriteServiceTile(
          favorite: favorite,
          onTap: onTap,
        );
    }
  }
}
import '../../domain/entities/favorite.dart';

class FavoriteModel extends Favorite {
  const FavoriteModel({
    required super.id,
    required super.userId,
    required super.entityId,
    required super.type,
    required super.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      entityId: json['entity_id']?.toString() ?? '',
      type: _parseType(
        json['entity_type']?.toString() ?? '',
      ),
      createdAt: DateTime.tryParse(
        json['created_at']?.toString() ?? '',
      ) ??
          DateTime.now(),
    );
  }

  factory FavoriteModel.fromEntity(
      Favorite favorite,
      ) {
    return FavoriteModel(
      id: favorite.id,
      userId: favorite.userId,
      entityId: favorite.entityId,
      type: favorite.type,
      createdAt: favorite.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'entity_id': entityId,
      'entity_type': type.name,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static FavoriteType _parseType(
      String value,
      ) {
    switch (value.toLowerCase()) {
      case 'business':
        return FavoriteType.business;

      case 'product':
        return FavoriteType.product;

      case 'service':
        return FavoriteType.service;

      default:
        return FavoriteType.business;
    }
  }
}
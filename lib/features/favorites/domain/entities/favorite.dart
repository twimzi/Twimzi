import 'package:equatable/equatable.dart';

enum FavoriteType {
  business,
  product,
  service,
}

class Favorite extends Equatable {
  const Favorite({
    required this.id,
    required this.userId,
    required this.entityId,
    required this.type,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final String entityId;
  final FavoriteType type;
  final DateTime createdAt;

  bool get isBusiness => type == FavoriteType.business;

  bool get isProduct => type == FavoriteType.product;

  bool get isService => type == FavoriteType.service;

  @override
  List<Object?> get props => [
    id,
    userId,
    entityId,
    type,
    createdAt,
  ];

  Favorite copyWith({
    String? id,
    String? userId,
    String? entityId,
    FavoriteType? type,
    DateTime? createdAt,
  }) {
    return Favorite(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      entityId: entityId ?? this.entityId,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
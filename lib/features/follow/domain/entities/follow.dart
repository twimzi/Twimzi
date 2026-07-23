import 'package:equatable/equatable.dart';

class Follow extends Equatable {
  const Follow({
    required this.id,
    required this.followerId,
    required this.businessId,
    required this.createdAt,
  });

  /// Primary key
  final String id;

  /// User who follows the business
  final String followerId;

  /// Business being followed
  final String businessId;

  /// Follow date & time
  final DateTime createdAt;

  @override
  List<Object?> get props => [
    id,
    followerId,
    businessId,
    createdAt,
  ];

  Follow copyWith({
    String? id,
    String? followerId,
    String? businessId,
    DateTime? createdAt,
  }) {
    return Follow(
      id: id ?? this.id,
      followerId: followerId ?? this.followerId,
      businessId: businessId ?? this.businessId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
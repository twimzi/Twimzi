import '../../domain/entities/follow.dart';

class FollowModel extends Follow {
  const FollowModel({
    required super.id,
    required super.followerId,
    required super.businessId,
    required super.createdAt,
  });

  factory FollowModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return FollowModel(
      id: json['id']?.toString() ?? '',
      followerId: json['follower_id']?.toString() ?? '',
      businessId: json['business_id']?.toString() ?? '',
      createdAt: DateTime.tryParse(
        json['created_at']?.toString() ?? '',
      ) ??
          DateTime.now(),
    );
  }

  factory FollowModel.fromEntity(
      Follow follow,
      ) {
    return FollowModel(
      id: follow.id,
      followerId: follow.followerId,
      businessId: follow.businessId,
      createdAt: follow.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'follower_id': followerId,
      'business_id': businessId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
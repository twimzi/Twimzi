import '../../domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.businessId,
    required super.title,
    required super.description,
    required super.type,
    required super.images,
    required super.videoUrl,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: _parseType(json['type'] as String),
      images: List<String>.from(
        json['images'] ?? const <String>[],
      ),
      videoUrl: json['video_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(
        json['created_at'] as String,
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] as String,
      ),
    );
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      businessId: post.businessId,
      title: post.title,
      description: post.description,
      type: post.type,
      images: post.images,
      videoUrl: post.videoUrl,
      isActive: post.isActive,
      createdAt: post.createdAt,
      updatedAt: post.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'title': title,
      'description': description,
      'type': type.name,
      'images': images,
      'video_url': videoUrl,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static PostType _parseType(String value) {
    return PostType.values.firstWhere(
          (type) => type.name == value,
      orElse: () => PostType.update,
    );
  }
}
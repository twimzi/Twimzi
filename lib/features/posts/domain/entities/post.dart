import 'package:equatable/equatable.dart';

enum PostType {
  announcement,
  offer,
  product,
  service,
  event,
  update,
}

class Post extends Equatable {
  const Post({
    required this.id,
    required this.businessId,
    required this.title,
    required this.description,
    required this.type,
    required this.images,
    required this.videoUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String businessId;
  final String title;
  final String description;
  final PostType type;
  final List<String> images;
  final String? videoUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get hasImages => images.isNotEmpty;

  bool get hasVideo =>
      videoUrl != null && videoUrl!.trim().isNotEmpty;

  Post copyWith({
    String? id,
    String? businessId,
    String? title,
    String? description,
    PostType? type,
    List<String>? images,
    String? videoUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Post(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      images: images ?? this.images,
      videoUrl: videoUrl ?? this.videoUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    businessId,
    title,
    description,
    type,
    images,
    videoUrl,
    isActive,
    createdAt,
    updatedAt,
  ];
}
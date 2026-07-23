import '../../domain/entities/search_result.dart';

class SearchResultModel extends SearchResult {
  const SearchResultModel({
    required super.id,
    required super.entityType,
    required super.title,
    required super.subtitle,
    required super.businessId,
    required super.thumbnail,
    required super.rating,
    required super.featured,
    required super.score,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      id: json['id']?.toString() ?? '',
      entityType: json['entity_type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString(),
      businessId: json['business_id']?.toString(),
      thumbnail: json['thumbnail']?.toString(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      featured: json['featured'] as bool? ?? false,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entity_type': entityType,
      'title': title,
      'subtitle': subtitle,
      'business_id': businessId,
      'thumbnail': thumbnail,
      'rating': rating,
      'featured': featured,
      'score': score,
    };
  }

  factory SearchResultModel.fromEntity(SearchResult entity) {
    return SearchResultModel(
      id: entity.id,
      entityType: entity.entityType,
      title: entity.title,
      subtitle: entity.subtitle,
      businessId: entity.businessId,
      thumbnail: entity.thumbnail,
      rating: entity.rating,
      featured: entity.featured,
      score: entity.score,
    );
  }
}
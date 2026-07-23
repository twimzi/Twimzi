import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  const SearchResult({
    required this.id,
    required this.entityType,
    required this.title,
    required this.subtitle,
    required this.businessId,
    required this.thumbnail,
    required this.rating,
    required this.featured,
    required this.score,
  });

  final String id;
  final String entityType;
  final String title;
  final String? subtitle;
  final String? businessId;
  final String? thumbnail;
  final double rating;
  final bool featured;
  final double score;

  bool get isBusiness => entityType == 'business';

  bool get isProduct => entityType == 'product';

  bool get isService => entityType == 'service';

  @override
  List<Object?> get props => [
    id,
    entityType,
    title,
    subtitle,
    businessId,
    thumbnail,
    rating,
    featured,
    score,
  ];
}
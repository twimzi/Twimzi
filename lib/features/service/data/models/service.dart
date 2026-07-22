import 'package:flutter/foundation.dart';

@immutable
class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.businessId,
    this.categoryId,
    required this.serviceCode,
    required this.serviceName,
    required this.slug,
    this.shortDescription,
    this.description,
    this.durationMinutes,
    required this.startingPrice,
    this.currencyId,
    this.thumbnailMediaId,
    required this.isFeatured,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
  });

  final String id;
  final String businessId;
  final String? categoryId;

  final String serviceCode;
  final String serviceName;
  final String slug;

  final String? shortDescription;
  final String? description;

  final int? durationMinutes;

  final double startingPrice;

  final String? currencyId;
  final String? thumbnailMediaId;

  final bool isFeatured;
  final bool isActive;

  final DateTime createdAt;
  final DateTime updatedAt;

  final String? createdBy;
  final String? updatedBy;

  final DateTime? deletedAt;

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      categoryId: json['category_id'] as String?,
      serviceCode: json['service_code'] as String,
      serviceName: json['service_name'] as String,
      slug: json['slug'] as String,
      shortDescription: json['short_description'] as String?,
      description: json['description'] as String?,
      durationMinutes: json['duration_minutes'] as int?,
      startingPrice:
      (json['starting_price'] as num?)?.toDouble() ?? 0,
      currencyId: json['currency_id'] as String?,
      thumbnailMediaId: json['thumbnail_media_id'] as String?,
      isFeatured: json['is_featured'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'category_id': categoryId,
      'service_code': serviceCode,
      'service_name': serviceName,
      'slug': slug,
      'short_description': shortDescription,
      'description': description,
      'duration_minutes': durationMinutes,
      'starting_price': startingPrice,
      'currency_id': currencyId,
      'thumbnail_media_id': thumbnailMediaId,
      'is_featured': isFeatured,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  ServiceModel copyWith({
    String? id,
    String? businessId,
    String? categoryId,
    String? serviceCode,
    String? serviceName,
    String? slug,
    String? shortDescription,
    String? description,
    int? durationMinutes,
    double? startingPrice,
    String? currencyId,
    String? thumbnailMediaId,
    bool? isFeatured,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? updatedBy,
    DateTime? deletedAt,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      categoryId: categoryId ?? this.categoryId,
      serviceCode: serviceCode ?? this.serviceCode,
      serviceName: serviceName ?? this.serviceName,
      slug: slug ?? this.slug,
      shortDescription: shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      startingPrice: startingPrice ?? this.startingPrice,
      currencyId: currencyId ?? this.currencyId,
      thumbnailMediaId: thumbnailMediaId ?? this.thumbnailMediaId,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}

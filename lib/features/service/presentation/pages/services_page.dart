class ServiceModel {
  final String id;

  final String businessId;
  final String? categoryId;

  final String serviceCode;

  final String serviceName;
  final String slug;

  final String shortDescription;
  final String description;

  /// Pricing
  final double price;
  final String pricingType;

  /// Duration
  final int durationMinutes;

  /// Images
  final String? thumbnailUrl;
  final List<String> galleryImages;
  final int imageCount;

  /// Status
  final bool isFeatured;
  final bool isActive;

  /// Audit
  final DateTime createdAt;
  final DateTime updatedAt;

  final String? createdBy;
  final String? updatedBy;

  final DateTime? deletedAt;

  const ServiceModel({
    required this.id,
    required this.businessId,
    this.categoryId,
    required this.serviceCode,
    required this.serviceName,
    required this.slug,
    required this.shortDescription,
    required this.description,
    required this.price,
    required this.pricingType,
    required this.durationMinutes,
    this.thumbnailUrl,
    this.galleryImages = const [],
    this.imageCount = 0,
    this.isFeatured = false,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
  });

  factory ServiceModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return ServiceModel(
      id: json['id'] as String,

      businessId: json['business_id'] as String,
      categoryId: json['category_id'] as String?,

      serviceCode: json['service_code'] as String,

      serviceName: json['service_name'] as String,
      slug: json['slug'] as String,

      shortDescription:
      (json['short_description'] ?? '') as String,
      description:
      (json['description'] ?? '') as String,

      price: (json['price'] as num).toDouble(),
      pricingType:
      (json['pricing_type'] ?? 'fixed') as String,

      durationMinutes:
      (json['duration_minutes'] ?? 0) as int,

      thumbnailUrl: json['thumbnail_url'] as String?,

      galleryImages:
      (json['gallery_images'] as List<dynamic>?)
          ?.cast<String>() ??
          const [],

      imageCount:
      (json['image_count'] ?? 0) as int,

      isFeatured:
      (json['is_featured'] ?? false) as bool,

      isActive:
      (json['is_active'] ?? true) as bool,

      createdAt:
      DateTime.parse(json['created_at'] as String),

      updatedAt:
      DateTime.parse(json['updated_at'] as String),

      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,

      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(
        json['deleted_at'] as String,
      ),
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
      'price': price,
      'pricing_type': pricingType,
      'duration_minutes': durationMinutes,
      'thumbnail_url': thumbnailUrl,
      'gallery_images': galleryImages,
      'image_count': imageCount,
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
    double? price,
    String? pricingType,
    int? durationMinutes,
    String? thumbnailUrl,
    List<String>? galleryImages,
    int? imageCount,
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
      shortDescription:
      shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      price: price ?? this.price,
      pricingType: pricingType ?? this.pricingType,
      durationMinutes:
      durationMinutes ?? this.durationMinutes,
      thumbnailUrl:
      thumbnailUrl ?? this.thumbnailUrl,
      galleryImages:
      galleryImages ?? this.galleryImages,
      imageCount: imageCount ?? this.imageCount,
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
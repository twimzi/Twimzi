import 'dart:io';

class CreateServiceRequest {
  const CreateServiceRequest({
    required this.businessId,
    required this.categoryId,
    required this.serviceCode,
    required this.serviceName,
    required this.shortDescription,
    required this.description,
    required this.price,
    required this.pricingType,
    required this.durationMinutes,
    required this.isFeatured,
    required this.isActive,
    this.thumbnail,
    this.galleryImages = const [],
  });

  final String businessId;
  final String categoryId;
  final String serviceCode;
  final String serviceName;
  final String shortDescription;
  final String description;

  /// Starting price
  final double price;

  /// fixed / hourly / daily / monthly / custom
  final String pricingType;

  final int durationMinutes;

  final bool isFeatured;
  final bool isActive;

  final File? thumbnail;
  final List<File> galleryImages;

  bool get hasThumbnail => thumbnail != null;

  bool get hasGalleryImages => galleryImages.isNotEmpty;

  int get totalImages =>
      galleryImages.length + (thumbnail == null ? 0 : 1);

  CreateServiceRequest copyWith({
    String? businessId,
    String? categoryId,
    String? serviceCode,
    String? serviceName,
    String? shortDescription,
    String? description,
    double? price,
    String? pricingType,
    int? durationMinutes,
    bool? isFeatured,
    bool? isActive,
    File? thumbnail,
    List<File>? galleryImages,
  }) {
    return CreateServiceRequest(
      businessId: businessId ?? this.businessId,
      categoryId: categoryId ?? this.categoryId,
      serviceCode: serviceCode ?? this.serviceCode,
      serviceName: serviceName ?? this.serviceName,
      shortDescription:
      shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      price: price ?? this.price,
      pricingType: pricingType ?? this.pricingType,
      durationMinutes:
      durationMinutes ?? this.durationMinutes,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      thumbnail: thumbnail ?? this.thumbnail,
      galleryImages:
      galleryImages ?? this.galleryImages,
    );
  }
}
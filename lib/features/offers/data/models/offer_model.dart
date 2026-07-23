import '../../domain/entities/offer.dart';

class OfferModel extends Offer {
  const OfferModel({
    required super.id,
    required super.businessId,
    required super.title,
    required super.description,
    required super.type,
    required super.offerValue,
    required super.startDate,
    required super.endDate,
    required super.isActive,
    required super.isFeatured,
    required super.imageUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  factory OfferModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return OfferModel(
      id: json['id']?.toString() ?? '',
      businessId: json['business_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      type: _parseType(
        json['offer_type']?.toString() ?? '',
      ),
      offerValue:
      (json['offer_value'] as num?)?.toDouble() ?? 0,
      startDate: DateTime.tryParse(
        json['start_date']?.toString() ?? '',
      ) ??
          DateTime.now(),
      endDate: DateTime.tryParse(
        json['end_date']?.toString() ?? '',
      ) ??
          DateTime.now(),
      isActive: json['is_active'] as bool? ?? false,
      isFeatured: json['is_featured'] as bool? ?? false,
      imageUrl: json['image_url']?.toString(),
      createdAt: DateTime.tryParse(
        json['created_at']?.toString() ?? '',
      ) ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(
        json['updated_at']?.toString() ?? '',
      ) ??
          DateTime.now(),
    );
  }

  factory OfferModel.fromEntity(
      Offer offer,
      ) {
    return OfferModel(
      id: offer.id,
      businessId: offer.businessId,
      title: offer.title,
      description: offer.description,
      type: offer.type,
      offerValue: offer.offerValue,
      startDate: offer.startDate,
      endDate: offer.endDate,
      isActive: offer.isActive,
      isFeatured: offer.isFeatured,
      imageUrl: offer.imageUrl,
      createdAt: offer.createdAt,
      updatedAt: offer.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'title': title,
      'description': description,
      'offer_type': type.name,
      'offer_value': offerValue,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_active': isActive,
      'is_featured': isFeatured,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static OfferType _parseType(
      String value,
      ) {
    switch (value.toLowerCase()) {
      case 'discount':
        return OfferType.discount;

      case 'flat':
        return OfferType.flat;

      case 'cashback':
        return OfferType.cashback;

      case 'buyonegetone':
        return OfferType.buyOneGetOne;

      case 'freeservice':
        return OfferType.freeService;

      case 'seasonal':
        return OfferType.seasonal;

      case 'custom':
        return OfferType.custom;

      default:
        return OfferType.discount;
    }
  }
}
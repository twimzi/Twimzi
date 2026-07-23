import 'package:equatable/equatable.dart';

enum OfferType {
  discount,
  flat,
  cashback,
  buyOneGetOne,
  freeService,
  seasonal,
  custom,
}

class Offer extends Equatable {
  const Offer({
    required this.id,
    required this.businessId,
    required this.title,
    required this.description,
    required this.type,
    required this.offerValue,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.isFeatured,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String businessId;

  final String title;
  final String description;

  final OfferType type;

  /// Percentage or flat amount depending on offer type.
  final double offerValue;

  final DateTime startDate;
  final DateTime endDate;

  final bool isActive;
  final bool isFeatured;

  final String? imageUrl;

  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isExpired => DateTime.now().isAfter(endDate);

  bool get isRunning =>
      isActive &&
          DateTime.now().isAfter(startDate) &&
          DateTime.now().isBefore(endDate);

  @override
  List<Object?> get props => [
    id,
    businessId,
    title,
    description,
    type,
    offerValue,
    startDate,
    endDate,
    isActive,
    isFeatured,
    imageUrl,
    createdAt,
    updatedAt,
  ];

  Offer copyWith({
    String? id,
    String? businessId,
    String? title,
    String? description,
    OfferType? type,
    double? offerValue,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    bool? isFeatured,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Offer(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      offerValue: offerValue ?? this.offerValue,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
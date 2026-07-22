import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceFormState {
  final String serviceName;
  final String shortDescription;
  final String description;

  final String categoryId;

  final double price;
  final String pricingType;

  final int durationMinutes;

  final bool isFeatured;
  final bool isActive;

  final File? thumbnail;
  final List<File> galleryImages;

  final bool isSubmitting;
  final bool completed;

  const ServiceFormState({
    this.serviceName = '',
    this.shortDescription = '',
    this.description = '',
    this.categoryId = '',
    this.price = 0,
    this.pricingType = 'fixed',
    this.durationMinutes = 30,
    this.isFeatured = false,
    this.isActive = true,
    this.thumbnail,
    this.galleryImages = const [],
    this.isSubmitting = false,
    this.completed = false,
  });

  bool get isValid =>
      serviceName.trim().isNotEmpty &&
          categoryId.trim().isNotEmpty &&
          price >= 0 &&
          durationMinutes > 0;

  ServiceFormState copyWith({
    String? serviceName,
    String? shortDescription,
    String? description,
    String? categoryId,
    double? price,
    String? pricingType,
    int? durationMinutes,
    bool? isFeatured,
    bool? isActive,
    File? thumbnail,
    List<File>? galleryImages,
    bool? isSubmitting,
    bool? completed,
  }) {
    return ServiceFormState(
      serviceName: serviceName ?? this.serviceName,
      shortDescription:
      shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      pricingType: pricingType ?? this.pricingType,
      durationMinutes:
      durationMinutes ?? this.durationMinutes,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      thumbnail: thumbnail ?? this.thumbnail,
      galleryImages:
      galleryImages ?? this.galleryImages,
      isSubmitting:
      isSubmitting ?? this.isSubmitting,
      completed: completed ?? this.completed,
    );
  }
}

class ServiceFormNotifier
    extends StateNotifier<ServiceFormState> {
  ServiceFormNotifier()
      : super(const ServiceFormState());

  void updateBasicInfo({
    required String serviceName,
    required String shortDescription,
    required String description,
    required String categoryId,
  }) {
    state = state.copyWith(
      serviceName: serviceName,
      shortDescription: shortDescription,
      description: description,
      categoryId: categoryId,
    );
  }

  void updatePricing({
    required double price,
    required String pricingType,
    required int durationMinutes,
  }) {
    state = state.copyWith(
      price: price,
      pricingType: pricingType,
      durationMinutes: durationMinutes,
    );
  }

  void updateImages({
    File? thumbnail,
    List<File>? galleryImages,
  }) {
    state = state.copyWith(
      thumbnail: thumbnail,
      galleryImages: galleryImages,
    );
  }

  void updateStatus({
    required bool isFeatured,
    required bool isActive,
  }) {
    state = state.copyWith(
      isFeatured: isFeatured,
      isActive: isActive,
    );
  }

  void setSubmitting(bool value) {
    state = state.copyWith(
      isSubmitting: value,
    );
  }

  void setCompleted(bool value) {
    state = state.copyWith(
      completed: value,
    );
  }

  void reset() {
    state = const ServiceFormState();
  }
}

final serviceFormProvider = StateNotifierProvider<
    ServiceFormNotifier,
    ServiceFormState>(
      (ref) => ServiceFormNotifier(),
);
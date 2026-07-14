import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/business_repository.dart';
import '../models/business_registration_state.dart';

final businessRepositoryProvider = Provider<BusinessRepository>(
      (ref) => BusinessRepository(),
);

final businessRegistrationProvider = StateNotifierProvider<
    BusinessRegistrationNotifier,
    BusinessRegistrationState>(
      (ref) => BusinessRegistrationNotifier(
    ref.read(businessRepositoryProvider),
  ),
);

class BusinessRegistrationNotifier
    extends StateNotifier<BusinessRegistrationState> {
  BusinessRegistrationNotifier(
      this._repository,
      ) : super(
    BusinessRegistrationState.initial(),
  );

  // ignore: unused_field
  final BusinessRepository _repository;

  void updateBusinessInfo({
    required String businessName,
    required String tagline,
    required String description,
    required String businessType,
    required String category,
  }) {
    state = state.copyWith(
      businessName: businessName,
      tagline: tagline,
      description: description,
      businessType: businessType,
      category: category,
    );
  }

  void updateLocation({
    required String address,
    required String city,
    required String stateName,
    required String country,
    required String postalCode,
  }) {
    state = state.copyWith(
      address: address,
      city: city,
      state: stateName,
      country: country,
      postalCode: postalCode,
    );
  }

  void updateContact({
    required String phone,
    required String whatsapp,
    required String email,
    required String website,
    required String facebook,
    required String instagram,
    required String youtube,
  }) {
    state = state.copyWith(
      phone: phone,
      whatsapp: whatsapp,
      email: email,
      website: website,
      facebook: facebook,
      instagram: instagram,
      youtube: youtube,
    );
  }

  void updateImages({
    File? logo,
    File? coverImage,
  }) {
    state = state.copyWith(
      logo: logo,
      coverImage: coverImage,
    );
  }

  Future<bool> submitBusiness() async {
    try {
      state = state.copyWith(
        isSubmitting: true,
      );

      // TODO:
      // Upload media to Cloudflare R2
      // Save media records
      // Create business
      // Create address/contact/social records

      await Future.delayed(
        const Duration(seconds: 1),
      );

      state = state.copyWith(
        isSubmitting: false,
        completed: true,
      );

      return true;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
      );

      return false;
    }
  }

  void reset() {
    state = BusinessRegistrationState.initial();
  }
}
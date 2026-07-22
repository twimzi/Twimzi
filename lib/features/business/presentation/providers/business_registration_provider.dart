import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/business_repository.dart';
import '../../domain/models/create_business_request.dart';
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

  final BusinessRepository _repository;

  // ---------------------------------------------------------------------------
  // BUSINESS INFO
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // LOCATION
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // CONTACT
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // HANDLE
  // ---------------------------------------------------------------------------

  void updateHandle(String handle) {
    state = state.copyWith(
      handle: handle,
    );
  }

  // ---------------------------------------------------------------------------
  // IMAGES
  // ---------------------------------------------------------------------------

  void updateImages({
    File? logo,
    File? coverImage,
    List<File>? galleryImages,
  }) {
    state = state.copyWith(
      logo: logo,
      coverImage: coverImage,
      galleryImages: galleryImages,
    );
  }

  // ---------------------------------------------------------------------------
  // SUBMIT
  // ---------------------------------------------------------------------------

  Future<String?> submitBusiness() async {
    if (!state.isReadyToSubmit) {
      return null;
    }

    try {
      state = state.copyWith(
        isSubmitting: true,
      );

      final request = CreateBusinessRequest(
        businessName: state.businessName,
        tagline: state.tagline,
        description: state.description,
        businessType: state.businessType,
        category: state.category,
        handle: state.handle.trim().isEmpty ? null : state.handle.trim(),
        address: state.address,
        city: state.city,
        state: state.state,
        country: state.country,
        postalCode: state.postalCode,
        phone: state.phone,
        whatsapp: state.whatsapp,
        email: state.email,
        website: state.website,
        facebook: state.facebook,
        instagram: state.instagram,
        youtube: state.youtube,
        logo: state.logo,
        coverImage: state.coverImage,
        galleryImages: state.galleryImages,
      );

      // -----------------------------------------------------------------------
      // Cloudflare R2 Upload (Future)
      // -----------------------------------------------------------------------
      //
      // 1. Upload Logo
      // 2. Upload Cover Image
      // 3. Upload Gallery Images
      // 4. Save returned URLs
      //
      // -----------------------------------------------------------------------

      final businessId = await _repository.createBusiness(request);

      state = state.copyWith(
        isSubmitting: false,
        completed: true,
      );

      return businessId;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
      );

      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // RESET
  // ---------------------------------------------------------------------------

  void reset() {
    state = BusinessRegistrationState.initial();
  }
}
import 'dart:io';

class BusinessRegistrationState {
  final String businessName;
  final String tagline;
  final String description;

  final String businessType;
  final String category;

  /// Identity
  final String handle;

  /// Location
  final String address;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  /// Contact
  final String phone;
  final String whatsapp;
  final String email;
  final String website;

  /// Social
  final String facebook;
  final String instagram;
  final String youtube;

  /// Media
  final File? logo;
  final File? coverImage;
  final List<File> galleryImages;

  /// Status
  final bool isSubmitting;
  final bool completed;

  const BusinessRegistrationState({
    this.businessName = '',
    this.tagline = '',
    this.description = '',
    this.businessType = '',
    this.category = '',
    this.handle = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.postalCode = '',
    this.phone = '',
    this.whatsapp = '',
    this.email = '',
    this.website = '',
    this.facebook = '',
    this.instagram = '',
    this.youtube = '',
    this.logo,
    this.coverImage,
    this.galleryImages = const [],
    this.isSubmitting = false,
    this.completed = false,
  });

  bool get isStep1Valid =>
      businessName.trim().isNotEmpty &&
          businessType.trim().isNotEmpty &&
          category.trim().isNotEmpty;

  bool get isStep2Valid =>
      address.trim().isNotEmpty &&
          city.trim().isNotEmpty &&
          state.trim().isNotEmpty &&
          country.trim().isNotEmpty;

  bool get isStep3Valid => phone.trim().isNotEmpty;

  bool get isReadyToSubmit =>
      isStep1Valid &&
          isStep2Valid &&
          isStep3Valid;

  BusinessRegistrationState copyWith({
    String? businessName,
    String? tagline,
    String? description,
    String? businessType,
    String? category,
    String? handle,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? phone,
    String? whatsapp,
    String? email,
    String? website,
    String? facebook,
    String? instagram,
    String? youtube,
    File? logo,
    File? coverImage,
    List<File>? galleryImages,
    bool? isSubmitting,
    bool? completed,
  }) {
    return BusinessRegistrationState(
      businessName: businessName ?? this.businessName,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      businessType: businessType ?? this.businessType,
      category: category ?? this.category,
      handle: handle ?? this.handle,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      email: email ?? this.email,
      website: website ?? this.website,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      youtube: youtube ?? this.youtube,
      logo: logo ?? this.logo,
      coverImage: coverImage ?? this.coverImage,
      galleryImages: galleryImages ?? this.galleryImages,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      completed: completed ?? this.completed,
    );
  }

  factory BusinessRegistrationState.initial() {
    return const BusinessRegistrationState();
  }
}
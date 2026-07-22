import 'dart:io';

class CreateBusinessRequest {
  final String businessName;
  final String tagline;
  final String description;

  final String businessType;
  final String category;

  final String address;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  final String phone;
  final String whatsapp;
  final String email;
  final String website;

  final String facebook;
  final String instagram;
  final String youtube;

  /// Optional custom handle
  final String? handle;

  /// Media
  final File? logo;
  final File? coverImage;
  final List<File> galleryImages;

  const CreateBusinessRequest({
    required this.businessName,
    required this.tagline,
    required this.description,
    required this.businessType,
    required this.category,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.phone,
    required this.whatsapp,
    required this.email,
    required this.website,
    required this.facebook,
    required this.instagram,
    required this.youtube,
    this.handle,
    this.logo,
    this.coverImage,
    this.galleryImages = const [],
  });

  bool get isValid =>
      businessName.trim().isNotEmpty &&
          businessType.trim().isNotEmpty &&
          category.trim().isNotEmpty &&
          address.trim().isNotEmpty &&
          city.trim().isNotEmpty &&
          state.trim().isNotEmpty &&
          country.trim().isNotEmpty &&
          phone.trim().isNotEmpty;

  CreateBusinessRequest copyWith({
    String? businessName,
    String? tagline,
    String? description,
    String? businessType,
    String? category,
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
    String? handle,
    File? logo,
    File? coverImage,
    List<File>? galleryImages,
  }) {
    return CreateBusinessRequest(
      businessName: businessName ?? this.businessName,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      businessType: businessType ?? this.businessType,
      category: category ?? this.category,
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
      handle: handle ?? this.handle,
      logo: logo ?? this.logo,
      coverImage: coverImage ?? this.coverImage,
      galleryImages: galleryImages ?? this.galleryImages,
    );
  }
}
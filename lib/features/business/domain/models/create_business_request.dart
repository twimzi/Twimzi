import 'dart:io';

class CreateBusinessRequest {
  final String ownerProfileId;

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

  final File? logo;
  final File? coverImage;

  const CreateBusinessRequest({
    required this.ownerProfileId,
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
    this.logo,
    this.coverImage,
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
}
class ProfileModel {
  final String id;

  final String? fullName;
  final String? username;

  final String? email;
  final String? phone;

  final String? profilePhotoUrl;

  final String? bio;

  final String? gender;

  final DateTime? dateOfBirth;

  final String? languageId;

  final String? countryId;

  final String? stateId;

  final String? cityId;

  final bool isVerified;

  final bool isActive;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  const ProfileModel({
    required this.id,
    this.fullName,
    this.username,
    this.email,
    this.phone,
    this.profilePhotoUrl,
    this.bio,
    this.gender,
    this.dateOfBirth,
    this.languageId,
    this.countryId,
    this.stateId,
    this.cityId,
    this.isVerified = false,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'].toString(),
      fullName: json['full_name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      profilePhotoUrl: json['profile_photo_url'],
      bio: json['bio'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      languageId: json['language_id']?.toString(),
      countryId: json['country_id']?.toString(),
      stateId: json['state_id']?.toString(),
      cityId: json['city_id']?.toString(),
      isVerified: json['is_verified'] ?? false,
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'username': username,
      'email': email,
      'phone': phone,
      'profile_photo_url': profilePhotoUrl,
      'bio': bio,
      'gender': gender,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'language_id': languageId,
      'country_id': countryId,
      'state_id': stateId,
      'city_id': cityId,
      'is_verified': isVerified,
      'is_active': isActive,
    };
  }

  ProfileModel copyWith({
    String? id,
    String? fullName,
    String? username,
    String? email,
    String? phone,
    String? profilePhotoUrl,
    String? bio,
    String? gender,
    DateTime? dateOfBirth,
    String? languageId,
    String? countryId,
    String? stateId,
    String? cityId,
    bool? isVerified,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      languageId: languageId ?? this.languageId,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static const empty = ProfileModel(
    id: '',
  );
}
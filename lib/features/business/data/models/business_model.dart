class BusinessModel {
  final String id;
  final String ownerProfileId;

  final String businessCode;
  final String businessName;
  final String? legalName;
  final String? slug;
  final String? handle;
  final String? shareUrl;
  final String? description;

  final String businessType;

  final String? email;
  final String? phone;
  final String? whatsappNumber;
  final String? website;

  final String? logoMediaId;
  final String? coverMediaId;

  final int? establishedYear;

  final String? gstNumber;
  final String? panNumber;

  final String verificationStatus;
  final String businessStatus;

  final double averageRating;
  final int totalReviews;
  final int totalFollowers;
  final int totalViews;

  final bool isActive;

  final String? businessTypeId;
  final String? languageId;
  final String? currencyId;

  final DateTime createdAt;
  final DateTime updatedAt;

  final String? createdBy;
  final String? updatedBy;

  final DateTime? deletedAt;

  const BusinessModel({
    required this.id,
    required this.ownerProfileId,
    required this.businessCode,
    required this.businessName,
    this.legalName,
    this.slug,
    this.handle,
    this.shareUrl,
    this.description,
    required this.businessType,
    this.email,
    this.phone,
    this.whatsappNumber,
    this.website,
    this.logoMediaId,
    this.coverMediaId,
    this.establishedYear,
    this.gstNumber,
    this.panNumber,
    required this.verificationStatus,
    required this.businessStatus,
    required this.averageRating,
    required this.totalReviews,
    required this.totalFollowers,
    required this.totalViews,
    required this.isActive,
    this.businessTypeId,
    this.languageId,
    this.currencyId,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'] as String,
      ownerProfileId: json['owner_profile_id'] as String,
      businessCode: json['business_code'] as String,
      businessName: json['business_name'] as String,
      legalName: json['legal_name'] as String?,
      slug: json['slug'] as String?,
      handle: json['handle'] as String?,
      shareUrl: json['share_url'] as String?,
      description: json['description'] as String?,
      businessType: json['business_type'] as String,
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      whatsappNumber: json['whatsapp_number']?.toString(),
      website: json['website'] as String?,
      logoMediaId: json['logo_media_id'] as String?,
      coverMediaId: json['cover_media_id'] as String?,
      establishedYear: json['established_year'] as int?,
      gstNumber: json['gst_number'] as String?,
      panNumber: json['pan_number'] as String?,
      verificationStatus: json['verification_status'].toString(),
      businessStatus: json['business_status'].toString(),
      averageRating: (json['average_rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      totalFollowers: json['total_followers'] ?? 0,
      totalViews: json['total_views'] ?? 0,
      isActive: json['is_active'] ?? true,
      businessTypeId: json['business_type_id'] as String?,
      languageId: json['language_id'] as String?,
      currencyId: json['currency_id'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_profile_id': ownerProfileId,
      'business_code': businessCode,
      'business_name': businessName,
      'legal_name': legalName,
      'slug': slug,
      'handle': handle,
      'share_url': shareUrl,
      'description': description,
      'business_type': businessType,
      'email': email,
      'phone': phone,
      'whatsapp_number': whatsappNumber,
      'website': website,
      'logo_media_id': logoMediaId,
      'cover_media_id': coverMediaId,
      'established_year': establishedYear,
      'gst_number': gstNumber,
      'pan_number': panNumber,
      'verification_status': verificationStatus,
      'business_status': businessStatus,
      'average_rating': averageRating,
      'total_reviews': totalReviews,
      'total_followers': totalFollowers,
      'total_views': totalViews,
      'is_active': isActive,
      'business_type_id': businessTypeId,
      'language_id': languageId,
      'currency_id': currencyId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
import 'business_contact.dart';
import 'business_hours.dart';
import 'business_location.dart';
import 'business_module.dart';
import 'business_social.dart';
import 'business_verification.dart';

class BusinessIdentity {
  final String id;
  final String ownerId;

  final String name;
  final String slug;

  /// Public URL Handle
  /// Example: @twimzi
  final String handle;

  /// https://twimzi.com/@handle
  final String shareUrl;

  final String tagline;
  final String description;

  final String logo;
  final String coverImage;

  /// Cloudflare R2 Gallery
  final List<String> galleryImages;

  final String businessType;
  final String category;

  final BusinessContact contact;
  final BusinessLocation location;
  final BusinessVerification verification;
  final BusinessHours hours;
  final BusinessSocial social;

  final List<BusinessModule> modules;

  final bool isOpen;
  final bool isActive;

  /// Profile
  final int profileCompletion;

  /// Promotion
  final bool featured;
  final bool boosted;
  final int priority;

  /// QR
  final String qrCodeUrl;
  final int qrScanCount;

  /// Digital Card
  final String businessCardUrl;
  final int businessCardShareCount;

  /// SEO
  final String metaTitle;
  final String metaDescription;

  final DateTime createdAt;
  final DateTime updatedAt;

  const BusinessIdentity({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.slug,
    required this.handle,
    required this.shareUrl,
    required this.tagline,
    required this.description,
    required this.logo,
    required this.coverImage,
    required this.galleryImages,
    required this.businessType,
    required this.category,
    required this.contact,
    required this.location,
    required this.verification,
    required this.hours,
    required this.social,
    required this.modules,
    required this.isOpen,
    required this.isActive,
    required this.profileCompletion,
    required this.featured,
    required this.boosted,
    required this.priority,
    required this.qrCodeUrl,
    required this.qrScanCount,
    required this.businessCardUrl,
    required this.businessCardShareCount,
    required this.metaTitle,
    required this.metaDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BusinessIdentity.fromJson(Map<String, dynamic> json) {
    return BusinessIdentity(
      id: json['id'].toString(),
      ownerId: json['owner_profile_id']?.toString() ?? '',
      name: json['business_name'] ?? '',
      slug: json['slug'] ?? '',
      handle: json['handle'] ?? '',
      shareUrl: json['share_url'] ?? '',
      tagline: json['tagline'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo_media_id']?.toString() ?? '',
      coverImage: json['cover_media_id']?.toString() ?? '',
      galleryImages: (json['gallery_images'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          const [],
      businessType: json['business_type'] ?? '',
      category: json['category_name'] ?? '',
      contact: BusinessContact(
        phone: json['phone'] ?? '',
        whatsapp: json['whatsapp_number'] ?? '',
        email: json['email'] ?? '',
        website: json['website'] ?? '',
      ),
      location: BusinessLocation(
        address: json['address'] ?? '',
        city: json['city'] ?? '',
        state: json['state'] ?? '',
        country: json['country'] ?? '',
        postalCode: json['postal_code'] ?? '',
        latitude: (json['latitude'] ?? 0).toDouble(),
        longitude: (json['longitude'] ?? 0).toDouble(),
      ),
      verification: BusinessVerification(
        phoneVerified: false,
        emailVerified: false,
        addressVerified: false,
        gstVerified: false,
        verifiedBusiness:
        json['verification_status'] == 'verified',
      ),
      hours: const BusinessHours(
        monday: '',
        tuesday: '',
        wednesday: '',
        thursday: '',
        friday: '',
        saturday: '',
        sunday: '',
      ),
      social: const BusinessSocial(
        facebook: '',
        instagram: '',
        linkedin: '',
        youtube: '',
        twitter: '',
      ),
      modules: const [],
      isOpen: false,
      isActive: json['is_active'] ?? true,
      profileCompletion: json['profile_completion'] ?? 0,
      featured: json['featured'] ?? false,
      boosted: json['boosted'] ?? false,
      priority: json['priority'] ?? 0,
      qrCodeUrl: json['qr_code_url'] ?? '',
      qrScanCount: json['qr_scan_count'] ?? 0,
      businessCardUrl: json['business_card_url'] ?? '',
      businessCardShareCount:
      json['business_card_share_count'] ?? 0,
      metaTitle: json['meta_title'] ?? '',
      metaDescription: json['meta_description'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner_profile_id': ownerId,
      'business_name': name,
      'slug': slug,
      'handle': handle,
      'share_url': shareUrl,
      'tagline': tagline,
      'description': description,
      'logo_media_id': logo,
      'cover_media_id': coverImage,
      'gallery_images': galleryImages,
      'business_type': businessType,
      'phone': contact.phone,
      'whatsapp_number': contact.whatsapp,
      'email': contact.email,
      'website': contact.website,
      'address': location.address,
      'city': location.city,
      'state': location.state,
      'country': location.country,
      'postal_code': location.postalCode,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'profile_completion': profileCompletion,
      'featured': featured,
      'boosted': boosted,
      'priority': priority,
      'qr_code_url': qrCodeUrl,
      'qr_scan_count': qrScanCount,
      'business_card_url': businessCardUrl,
      'business_card_share_count': businessCardShareCount,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'is_active': isActive,
    };
  }

  BusinessIdentity copyWith({
    String? id,
    String? ownerId,
    String? name,
    String? slug,
    String? handle,
    String? shareUrl,
    String? tagline,
    String? description,
    String? logo,
    String? coverImage,
    List<String>? galleryImages,
    String? businessType,
    String? category,
    BusinessContact? contact,
    BusinessLocation? location,
    BusinessVerification? verification,
    BusinessHours? hours,
    BusinessSocial? social,
    List<BusinessModule>? modules,
    bool? isOpen,
    bool? isActive,
    int? profileCompletion,
    bool? featured,
    bool? boosted,
    int? priority,
    String? qrCodeUrl,
    int? qrScanCount,
    String? businessCardUrl,
    int? businessCardShareCount,
    String? metaTitle,
    String? metaDescription,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BusinessIdentity(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      handle: handle ?? this.handle,
      shareUrl: shareUrl ?? this.shareUrl,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      coverImage: coverImage ?? this.coverImage,
      galleryImages: galleryImages ?? this.galleryImages,
      businessType: businessType ?? this.businessType,
      category: category ?? this.category,
      contact: contact ?? this.contact,
      location: location ?? this.location,
      verification: verification ?? this.verification,
      hours: hours ?? this.hours,
      social: social ?? this.social,
      modules: modules ?? this.modules,
      isOpen: isOpen ?? this.isOpen,
      isActive: isActive ?? this.isActive,
      profileCompletion:
      profileCompletion ?? this.profileCompletion,
      featured: featured ?? this.featured,
      boosted: boosted ?? this.boosted,
      priority: priority ?? this.priority,
      qrCodeUrl: qrCodeUrl ?? this.qrCodeUrl,
      qrScanCount: qrScanCount ?? this.qrScanCount,
      businessCardUrl:
      businessCardUrl ?? this.businessCardUrl,
      businessCardShareCount:
      businessCardShareCount ??
          this.businessCardShareCount,
      metaTitle: metaTitle ?? this.metaTitle,
      metaDescription:
      metaDescription ?? this.metaDescription,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
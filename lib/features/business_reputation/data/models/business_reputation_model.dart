import '../../domain/entities/business_reputation.dart';

class BusinessReputationModel extends BusinessReputation {
  const BusinessReputationModel({
    required super.businessId,
    required super.reputationScore,
    required super.profileCompletion,
    required super.verificationScore,
    required super.responseScore,
    required super.activityScore,
    required super.engagementScore,
    required super.yearsInBusiness,
    required super.followersCount,
    required super.viewsCount,
    required super.productsCount,
    required super.servicesCount,
    required super.postsCount,
    required super.lastActiveAt,
    required super.isVerified,
    required super.badges,
  });

  factory BusinessReputationModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return BusinessReputationModel(
      businessId: json['business_id']?.toString() ?? '',
      reputationScore:
      (json['reputation_score'] as num?)?.toDouble() ?? 0,
      profileCompletion:
      (json['profile_completion'] as num?)?.toInt() ?? 0,
      verificationScore:
      (json['verification_score'] as num?)?.toDouble() ?? 0,
      responseScore:
      (json['response_score'] as num?)?.toDouble() ?? 0,
      activityScore:
      (json['activity_score'] as num?)?.toDouble() ?? 0,
      engagementScore:
      (json['engagement_score'] as num?)?.toDouble() ?? 0,
      yearsInBusiness:
      (json['years_in_business'] as num?)?.toInt() ?? 0,
      followersCount:
      (json['followers_count'] as num?)?.toInt() ?? 0,
      viewsCount:
      (json['views_count'] as num?)?.toInt() ?? 0,
      productsCount:
      (json['products_count'] as num?)?.toInt() ?? 0,
      servicesCount:
      (json['services_count'] as num?)?.toInt() ?? 0,
      postsCount:
      (json['posts_count'] as num?)?.toInt() ?? 0,
      lastActiveAt: json['last_active_at'] != null
          ? DateTime.tryParse(
        json['last_active_at'].toString(),
      )
          : null,
      isVerified: json['is_verified'] as bool? ?? false,
      badges: (json['badges'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(growable: false) ??
          const [],
    );
  }

  factory BusinessReputationModel.fromEntity(
      BusinessReputation reputation,
      ) {
    return BusinessReputationModel(
      businessId: reputation.businessId,
      reputationScore: reputation.reputationScore,
      profileCompletion: reputation.profileCompletion,
      verificationScore: reputation.verificationScore,
      responseScore: reputation.responseScore,
      activityScore: reputation.activityScore,
      engagementScore: reputation.engagementScore,
      yearsInBusiness: reputation.yearsInBusiness,
      followersCount: reputation.followersCount,
      viewsCount: reputation.viewsCount,
      productsCount: reputation.productsCount,
      servicesCount: reputation.servicesCount,
      postsCount: reputation.postsCount,
      lastActiveAt: reputation.lastActiveAt,
      isVerified: reputation.isVerified,
      badges: reputation.badges,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'business_id': businessId,
      'reputation_score': reputationScore,
      'profile_completion': profileCompletion,
      'verification_score': verificationScore,
      'response_score': responseScore,
      'activity_score': activityScore,
      'engagement_score': engagementScore,
      'years_in_business': yearsInBusiness,
      'followers_count': followersCount,
      'views_count': viewsCount,
      'products_count': productsCount,
      'services_count': servicesCount,
      'posts_count': postsCount,
      'last_active_at': lastActiveAt?.toIso8601String(),
      'is_verified': isVerified,
      'badges': badges,
    };
  }
}
import 'package:equatable/equatable.dart';

class BusinessReputation extends Equatable {
  const BusinessReputation({
    required this.businessId,
    required this.reputationScore,
    required this.profileCompletion,
    required this.verificationScore,
    required this.responseScore,
    required this.activityScore,
    required this.engagementScore,
    required this.yearsInBusiness,
    required this.followersCount,
    required this.viewsCount,
    required this.productsCount,
    required this.servicesCount,
    required this.postsCount,
    required this.lastActiveAt,
    required this.isVerified,
    required this.badges,
  });

  final String businessId;

  /// Overall score (0-100)
  final double reputationScore;

  /// Profile completion percentage (0-100)
  final int profileCompletion;

  /// Verification score (0-100)
  final double verificationScore;

  /// Response performance (0-100)
  final double responseScore;

  /// Business activity score (0-100)
  final double activityScore;

  /// Customer engagement score (0-100)
  final double engagementScore;

  /// Number of completed years
  final int yearsInBusiness;

  final int followersCount;
  final int viewsCount;
  final int productsCount;
  final int servicesCount;
  final int postsCount;

  final DateTime? lastActiveAt;

  final bool isVerified;

  final List<String> badges;

  bool get isExcellent => reputationScore >= 90;

  bool get isVeryGood => reputationScore >= 75;

  bool get isGood => reputationScore >= 60;

  bool get needsImprovement => reputationScore < 60;

  @override
  List<Object?> get props => [
    businessId,
    reputationScore,
    profileCompletion,
    verificationScore,
    responseScore,
    activityScore,
    engagementScore,
    yearsInBusiness,
    followersCount,
    viewsCount,
    productsCount,
    servicesCount,
    postsCount,
    lastActiveAt,
    isVerified,
    badges,
  ];

  BusinessReputation copyWith({
    String? businessId,
    double? reputationScore,
    int? profileCompletion,
    double? verificationScore,
    double? responseScore,
    double? activityScore,
    double? engagementScore,
    int? yearsInBusiness,
    int? followersCount,
    int? viewsCount,
    int? productsCount,
    int? servicesCount,
    int? postsCount,
    DateTime? lastActiveAt,
    bool? isVerified,
    List<String>? badges,
  }) {
    return BusinessReputation(
      businessId: businessId ?? this.businessId,
      reputationScore: reputationScore ?? this.reputationScore,
      profileCompletion: profileCompletion ?? this.profileCompletion,
      verificationScore: verificationScore ?? this.verificationScore,
      responseScore: responseScore ?? this.responseScore,
      activityScore: activityScore ?? this.activityScore,
      engagementScore: engagementScore ?? this.engagementScore,
      yearsInBusiness: yearsInBusiness ?? this.yearsInBusiness,
      followersCount: followersCount ?? this.followersCount,
      viewsCount: viewsCount ?? this.viewsCount,
      productsCount: productsCount ?? this.productsCount,
      servicesCount: servicesCount ?? this.servicesCount,
      postsCount: postsCount ?? this.postsCount,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      isVerified: isVerified ?? this.isVerified,
      badges: badges ?? this.badges,
    );
  }
}
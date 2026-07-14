class BusinessVerification {
  final bool phoneVerified;
  final bool emailVerified;
  final bool addressVerified;
  final bool gstVerified;

  final bool verifiedBusiness;

  const BusinessVerification({
    required this.phoneVerified,
    required this.emailVerified,
    required this.addressVerified,
    required this.gstVerified,
    required this.verifiedBusiness,
  });
}
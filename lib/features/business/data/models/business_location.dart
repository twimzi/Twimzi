class BusinessLocation {
  final String address;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  final double latitude;
  final double longitude;

  const BusinessLocation({
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
  });
}
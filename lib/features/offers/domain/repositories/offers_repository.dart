import '../entities/offer.dart';

abstract class OffersRepository {
  /// Returns all offers.
  Future<List<Offer>> getOffers();

  /// Returns a specific offer.
  Future<Offer> getOfferById({
    required String offerId,
  });

  /// Returns all offers of a business.
  Future<List<Offer>> getBusinessOffers({
    required String businessId,
  });

  /// Returns currently active offers.
  Future<List<Offer>> getActiveOffers();

  /// Returns featured offers.
  Future<List<Offer>> getFeaturedOffers();

  /// Returns whether an offer is active.
  Future<bool> isOfferActive({
    required String offerId,
  });

  /// Returns whether an offer has expired.
  Future<bool> isOfferExpired({
    required String offerId,
  });
}
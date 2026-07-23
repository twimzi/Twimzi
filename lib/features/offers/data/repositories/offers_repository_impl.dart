import '../../domain/entities/offer.dart';
import '../../domain/repositories/offers_repository.dart';
import '../datasources/offers_remote_datasource.dart';

class OffersRepositoryImpl implements OffersRepository {
  const OffersRepositoryImpl({
    required this._remoteDataSource,
  });

  final OffersRemoteDataSource _remoteDataSource;

  @override
  Future<List<Offer>> getOffers() {
    return _remoteDataSource.getOffers();
  }

  @override
  Future<Offer> getOfferById({
    required String offerId,
  }) {
    return _remoteDataSource.getOfferById(
      offerId: offerId,
    );
  }

  @override
  Future<List<Offer>> getBusinessOffers({
    required String businessId,
  }) {
    return _remoteDataSource.getBusinessOffers(
      businessId: businessId,
    );
  }

  @override
  Future<List<Offer>> getActiveOffers() {
    return _remoteDataSource.getActiveOffers();
  }

  @override
  Future<List<Offer>> getFeaturedOffers() {
    return _remoteDataSource.getFeaturedOffers();
  }

  @override
  Future<bool> isOfferActive({
    required String offerId,
  }) {
    return _remoteDataSource.isOfferActive(
      offerId: offerId,
    );
  }

  @override
  Future<bool> isOfferExpired({
    required String offerId,
  }) {
    return _remoteDataSource.isOfferExpired(
      offerId: offerId,
    );
  }
}
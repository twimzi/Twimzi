import '../entities/offer.dart';
import '../repositories/offers_repository.dart';

class GetOfferByIdUseCase {
  const GetOfferByIdUseCase({
    required this._repository,
  });

  final OffersRepository _repository;

  Future<Offer> call({
    required String offerId,
  }) {
    return _repository.getOfferById(
      offerId: offerId,
    );
  }
}
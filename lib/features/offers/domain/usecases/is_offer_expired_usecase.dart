import '../repositories/offers_repository.dart';

class IsOfferExpiredUseCase {
  const IsOfferExpiredUseCase({
    required this._repository,
  });

  final OffersRepository _repository;

  Future<bool> call({
    required String offerId,
  }) {
    return _repository.isOfferExpired(
      offerId: offerId,
    );
  }
}
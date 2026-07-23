import '../repositories/offers_repository.dart';

class IsOfferActiveUseCase {
  const IsOfferActiveUseCase({
    required this._repository,
  });

  final OffersRepository _repository;

  Future<bool> call({
    required String offerId,
  }) {
    return _repository.isOfferActive(
      offerId: offerId,
    );
  }
}
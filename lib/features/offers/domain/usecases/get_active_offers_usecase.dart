import '../entities/offer.dart';
import '../repositories/offers_repository.dart';

class GetActiveOffersUseCase {
  const GetActiveOffersUseCase({
    required this._repository,
  });

  final OffersRepository _repository;

  Future<List<Offer>> call() {
    return _repository.getActiveOffers();
  }
}
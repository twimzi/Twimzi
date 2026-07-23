import '../entities/offer.dart';
import '../repositories/offers_repository.dart';

class GetOffersUseCase {
  const GetOffersUseCase({
    required this._repository,
  });

  final OffersRepository _repository;

  Future<List<Offer>> call() {
    return _repository.getOffers();
  }
}
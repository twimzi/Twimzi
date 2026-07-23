import '../entities/offer.dart';
import '../repositories/offers_repository.dart';

class GetBusinessOffersUseCase {
  const GetBusinessOffersUseCase({
    required this._repository,
  });

  final OffersRepository _repository;

  Future<List<Offer>> call({
    required String businessId,
  }) {
    return _repository.getBusinessOffers(
      businessId: businessId,
    );
  }
}
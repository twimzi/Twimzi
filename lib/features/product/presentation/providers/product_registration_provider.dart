

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/product_repository.dart';
import 'product_provider.dart';

final productRegistrationProvider = StateNotifierProvider<
    ProductRegistrationNotifier,
    ProductRegistrationState>(
      (ref) => ProductRegistrationNotifier(
    ref.read(productRepositoryProvider),
  ),
);

class ProductRegistrationNotifier
    extends StateNotifier<ProductRegistrationState> {
  ProductRegistrationNotifier(this._repository)
      : super(ProductRegistrationState.initial());

  final ProductRepository _repository;

  Future<void> submit() async {
    throw UnimplementedError(
      'Complete implementation requires the synchronized BusinessRepository, '
          'CreateProductUseCase and Add Product flow.',
    );
  }
}

class ProductRegistrationState {
  const ProductRegistrationState();

  factory ProductRegistrationState.initial() =>
      const ProductRegistrationState();
}

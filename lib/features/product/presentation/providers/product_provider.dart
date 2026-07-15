import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/storage_provider.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>(
      (ref) => ProductRepository(
    storageRepository: ref.read(
      storageRepositoryProvider,
    ),
  ),
);

final productsProvider =
FutureProvider<List<ProductModel>>(
      (ref) async {
    return ref
        .read(productRepositoryProvider)
        .getProducts();
  },
);

final businessProductsProvider =
FutureProvider.family<
    List<ProductModel>,
    String>(
      (ref, businessId) async {
    return ref
        .read(productRepositoryProvider)
        .getBusinessProducts(
      businessId,
    );
  },
);

final productProvider =
FutureProvider.family<
    ProductModel,
    String>(
      (ref, productId) async {
    return ref
        .read(productRepositoryProvider)
        .getProduct(
      productId,
    );
  },
);

final watchProductsProvider =
StreamProvider<List<ProductModel>>(
      (ref) {
    return ref
        .read(productRepositoryProvider)
        .watchProducts();
  },
);

final watchBusinessProductsProvider =
StreamProvider.family<
    List<ProductModel>,
    String>(
      (ref, businessId) {
    return ref
        .read(productRepositoryProvider)
        .watchBusinessProducts(
      businessId,
    );
  },
);
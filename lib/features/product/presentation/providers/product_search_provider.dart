import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product_model.dart';
import 'product_provider.dart';

final productSearchQueryProvider =
StateProvider<String>(
      (ref) => '',
);

final filteredProductsProvider =
Provider<AsyncValue<List<ProductModel>>>(
      (ref) {
    final products =
    ref.watch(productsProvider);

    final query = ref
        .watch(productSearchQueryProvider)
        .trim()
        .toLowerCase();

    return products.whenData(
          (items) {
        if (query.isEmpty) {
          return items;
        }

        return items.where((product) {
          return product.productName
              .toLowerCase()
              .contains(query) ||
              product.productCode
                  .toLowerCase()
                  .contains(query) ||
              product.sku
                  .toLowerCase()
                  .contains(query) ||
              (product.brand ?? '')
                  .toLowerCase()
                  .contains(query);
        }).toList();
      },
    );
  },
);

final businessProductSearchProvider = Provider.family<
    AsyncValue<List<ProductModel>>,
    String>(
      (ref, businessId) {
    final products = ref.watch(
      businessProductsProvider(
        businessId,
      ),
    );

    final query = ref
        .watch(productSearchQueryProvider)
        .trim()
        .toLowerCase();

    return products.whenData(
          (items) {
        if (query.isEmpty) {
          return items;
        }

        return items.where((product) {
          return product.productName
              .toLowerCase()
              .contains(query) ||
              product.productCode
                  .toLowerCase()
                  .contains(query) ||
              product.sku
                  .toLowerCase()
                  .contains(query) ||
              (product.brand ?? '')
                  .toLowerCase()
                  .contains(query);
        }).toList();
      },
    );
  },
);
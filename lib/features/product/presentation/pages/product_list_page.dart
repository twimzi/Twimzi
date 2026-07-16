import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../widgets/add_product/empty_products_view.dart';
import '../widgets/add_product/product_card.dart';
import '../widgets/add_product/product_search_bar.dart';
import 'add_product_page.dart';
import 'product_details_page.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({
    super.key,
    required this.businessId,
  });

  final String businessId;

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(
      businessProductsProvider(businessId),
    );

    await ref.read(
      businessProductsProvider(businessId).future,
    );
  }

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final products =
    ref.watch(
      businessProductsProvider(businessId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
        ),
      ),
      floatingActionButton:
      FloatingActionButton.extended(
        heroTag: 'add_product',
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Product',
        ),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddProductPage(
                businessId: businessId,
              ),
            ),
          );

          if (context.mounted) {
            await _refresh(ref);
          }
        },
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: ProductSearchBar(),
          ),
          Expanded(
            child: products.when(
              loading: () => const Center(
                child:
                CircularProgressIndicator(),
              ),
              error: (error, _) => Center(
                child: Padding(
                  padding:
                  const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 56,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        error.toString(),
                        textAlign:
                        TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButton.icon(
                        onPressed: () =>
                            _refresh(ref),
                        icon: const Icon(
                          Icons.refresh,
                        ),
                        label: const Text(
                          'Retry',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () =>
                        _refresh(ref),
                    child: ListView(
                      physics:
                      const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(
                          height: 250,
                        ),
                        EmptyProductsView(),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      _refresh(ref),
                  child: ListView.separated(
                    padding:
                    const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder:
                        (_, _) =>
                    const SizedBox(
                      height: 12,
                    ),
                    itemBuilder:
                        (context, index) {
                      final product =
                      items[index];

                      return ProductCard(
                        product: product,
                        onTap: () async {
                          await Navigator.of(
                              context)
                              .push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailsPage(
                                    productId:
                                    product.id,
                                  ),
                            ),
                          );

                          if (context.mounted) {
                            await _refresh(ref);
                          }
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
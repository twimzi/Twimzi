import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';

class ProductListPage extends ConsumerStatefulWidget {
  final String businessId;

  const ProductListPage({
    super.key,
    required this.businessId,
  });

  @override
  ConsumerState<ProductListPage> createState() =>
      _ProductListPageState();
}

class _ProductListPageState
    extends ConsumerState<ProductListPage> {
  final TextEditingController _searchController =
  TextEditingController();

  bool _gridView = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(
      businessProductsProvider(widget.businessId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: Icon(
              _gridView
                  ? Icons.view_list
                  : Icons.grid_view,
            ),
            onPressed: () {
              setState(() {
                _gridView = !_gridView;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO
          // Navigate to Add Product Page
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Product"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search Products",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: productsAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (e, _) => Center(
                child: Text(e.toString()),
              ),
              data: (products) {
                if (products.isEmpty) {
                  return const Center(
                    child: Text(
                      "No products found.",
                    ),
                  );
                }

                if (_gridView) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: .82,
                    ),
                    itemBuilder: (_, index) {
                      final product = products[index];

                      return Card(
                        child: Padding(
                          padding:
                          const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius:
                                    BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.inventory_2,
                                    size: 50,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                product.productName,
                                maxLines: 2,
                                overflow:
                                TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "₹ ${product.sellingPrice}",
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Stock : ${product.stockQuantity}",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return ListView.separated(
                  itemCount: products.length,
                  separatorBuilder: (_, _) =>
                  const Divider(height: 1),
                  itemBuilder: (_, index) {
                    final product = products[index];

                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.inventory),
                      ),
                      title: Text(product.productName),
                      subtitle: Text(
                        "₹ ${product.sellingPrice}",
                      ),
                      trailing: Text(
                        "${product.stockQuantity}",
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
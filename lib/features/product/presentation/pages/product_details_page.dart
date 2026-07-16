
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import 'edit_product_page.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: productAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => Center(
          child: Text(e.toString()),
        ),
        data: (product) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (product.thumbnailUrl != null &&
                product.thumbnailUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.thumbnailUrl!,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Text(
              product.productName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Code: ${product.productCode}'),
            Text('SKU: ${product.sku}'),
            if (product.brand != null)
              Text('Brand: ${product.brand}'),
            if (product.model != null)
              Text('Model: ${product.model}'),
            const Divider(height: 32),
            ListTile(
              title: const Text('Selling Price'),
              trailing: Text(product.sellingPrice.toString()),
            ),
            ListTile(
              title: const Text('MRP'),
              trailing: Text(product.mrp.toString()),
            ),
            ListTile(
              title: const Text('Stock'),
              trailing: Text(product.stockQuantity.toString()),
            ),
            if (product.description.isNotEmpty) ...[
              const Divider(height: 32),
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(product.description),
            ],
          ],
        ),
      ),
      floatingActionButton: productAsync.whenOrNull(
        data: (product) => FloatingActionButton.extended(
          icon: const Icon(Icons.edit),
          label: const Text('Edit'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EditProductPage(
                  productId: product.id,
                  businessId: product.businessId,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

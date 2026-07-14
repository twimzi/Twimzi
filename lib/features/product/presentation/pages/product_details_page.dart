import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product_model.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
    this.onEdit,
    this.onDelete,
  });

  final ProductModel product;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
        actions: [
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit',
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(theme),
          const SizedBox(height: 24),

          _sectionTitle(
            context,
            'Basic Information',
          ),

          _infoTile(
            'Product Name',
            product.productName,
          ),

          _infoTile(
            'Product Code',
            product.productCode,
          ),

          _infoTile(
            'SKU',
            product.sku,
          ),

          _infoTile(
            'Barcode',
            product.barcode ?? '-',
          ),

          _infoTile(
            'Brand',
            product.brand ?? '-',
          ),

          _infoTile(
            'Model',
            product.model ?? '-',
          ),

          _infoTile(
            'Short Description',
            product.shortDescription,
          ),

          _infoTile(
            'Description',
            product.description,
          ),

          const SizedBox(height: 24),

          _sectionTitle(
            context,
            'Pricing',
          ),

          _infoTile(
            'Selling Price',
            '₹ ${product.sellingPrice.toStringAsFixed(2)}',
          ),

          _infoTile(
            'MRP',
            '₹ ${product.mrp.toStringAsFixed(2)}',
          ),

          _infoTile(
            'Cost Price',
            '₹ ${product.costPrice.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 24),

          _sectionTitle(
            context,
            'Inventory',
          ),

          _infoTile(
            'Stock',
            product.stockQuantity.toString(),
          ),

          _infoTile(
            'Minimum Stock',
            product.minimumStock.toString(),
          ),

          _infoTile(
            'Maximum Stock',
            product.maximumStock.toString(),
          ),

          const SizedBox(height: 24),

          _sectionTitle(
            context,
            'Dimensions',
          ),

          _infoTile(
            'Weight',
            product.weight.toString(),
          ),

          _infoTile(
            'Length',
            product.length.toString(),
          ),

          _infoTile(
            'Width',
            product.width.toString(),
          ),

          _infoTile(
            'Height',
            product.height.toString(),
          ),

          const SizedBox(height: 24),

          _sectionTitle(
            context,
            'Status',
          ),

          SwitchListTile(
            value: product.isActive,
            onChanged: null,
            title: const Text(
              'Active Product',
            ),
          ),

          SwitchListTile(
            value: product.isFeatured,
            onChanged: null,
            title: const Text(
              'Featured Product',
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              child: Icon(
                Icons.inventory_2_outlined,
                size: 36,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.productName,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(
                product.isActive
                    ? 'Active'
                    : 'Inactive',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(
      BuildContext context,
      String title,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoTile(
      String title,
      String value,
      ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
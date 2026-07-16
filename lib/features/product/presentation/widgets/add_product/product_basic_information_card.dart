
import 'package:flutter/material.dart';

class ProductBasicInformationCard extends StatelessWidget {
  const ProductBasicInformationCard({
    super.key,
    required this.productNameController,
    required this.productCodeController,
    required this.skuController,
    required this.barcodeController,
    required this.brandController,
    required this.modelController,
    required this.shortDescriptionController,
    required this.descriptionController,
    this.categoryItems = const [],
    this.selectedCategory,
    this.onCategoryChanged,
  });

  final TextEditingController productNameController;
  final TextEditingController productCodeController;
  final TextEditingController skuController;
  final TextEditingController barcodeController;
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController shortDescriptionController;
  final TextEditingController descriptionController;
  final List<DropdownMenuItem<String>> categoryItems;
  final String? selectedCategory;
  final ValueChanged<String?>? onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Basic Information', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            TextFormField(
              controller: productNameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                prefixIcon: Icon(Icons.inventory_2_outlined),
              ),
              validator: (v) => v == null || v.trim().isEmpty ? 'Product name is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: productCodeController,
              decoration: const InputDecoration(
                labelText: 'Product Code',
                prefixIcon: Icon(Icons.qr_code),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: skuController,
              decoration: const InputDecoration(
                labelText: 'SKU',
                prefixIcon: Icon(Icons.sell_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: barcodeController,
              decoration: const InputDecoration(
                labelText: 'Barcode',
                prefixIcon: Icon(Icons.qr_code_scanner),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: brandController,
              decoration: const InputDecoration(
                labelText: 'Brand',
                prefixIcon: Icon(Icons.business),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: modelController,
              decoration: const InputDecoration(
                labelText: 'Model',
                prefixIcon: Icon(Icons.precision_manufacturing),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: selectedCategory,
              items: categoryItems,
              onChanged: onCategoryChanged,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category_outlined),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: shortDescriptionController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Short Description',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.short_text),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              minLines: 5,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.description_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

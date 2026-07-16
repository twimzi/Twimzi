import 'package:flutter/material.dart';

class ProductInventoryCard extends StatelessWidget {
  const ProductInventoryCard({
    super.key,
    required this.stockQuantityController,
    required this.minimumStockController,
    required this.maximumStockController,
  });

  final TextEditingController stockQuantityController;
  final TextEditingController minimumStockController;
  final TextEditingController maximumStockController;

  String? _validateInt(
      String? value, {
        bool required = false,
      }) {
    if (value == null || value.trim().isEmpty) {
      return required
          ? 'This field is required.'
          : null;
    }

    if (int.tryParse(value.trim()) == null) {
      return 'Enter a valid integer.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inventory',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: stockQuantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stock Quantity',
                prefixIcon: Icon(Icons.inventory),
              ),
              validator: (value) =>
                  _validateInt(value, required: true),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: minimumStockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Minimum Stock',
                prefixIcon: Icon(Icons.remove_circle_outline),
              ),
              validator: _validateInt,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: maximumStockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Maximum Stock',
                prefixIcon: Icon(Icons.add_circle_outline),
              ),
              validator: _validateInt,
            ),
          ],
        ),
      ),
    );
  }
}
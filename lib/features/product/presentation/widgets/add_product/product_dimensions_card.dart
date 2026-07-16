
import 'package:flutter/material.dart';

class ProductDimensionsCard extends StatelessWidget {
  const ProductDimensionsCard({
    super.key,
    required this.weightController,
    required this.lengthController,
    required this.widthController,
    required this.heightController,
  });

  final TextEditingController weightController;
  final TextEditingController lengthController;
  final TextEditingController widthController;
  final TextEditingController heightController;

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (double.tryParse(value.trim()) == null) {
      return 'Enter a valid number';
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
              'Dimensions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                prefixIcon: Icon(Icons.scale_outlined),
              ),
              validator: _validate,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: lengthController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Length',
                prefixIcon: Icon(Icons.straighten),
              ),
              validator: _validate,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: widthController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Width',
                prefixIcon: Icon(Icons.width_normal_outlined),
              ),
              validator: _validate,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: heightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Height',
                prefixIcon: Icon(Icons.height_outlined),
              ),
              validator: _validate,
            ),
          ],
        ),
      ),
    );
  }
}

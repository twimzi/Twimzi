
import 'package:flutter/material.dart';

class ProductPricingCard extends StatelessWidget {
  const ProductPricingCard({
    super.key,
    required this.sellingPriceController,
    required this.mrpController,
    required this.costPriceController,
  });

  final TextEditingController sellingPriceController;
  final TextEditingController mrpController;
  final TextEditingController costPriceController;

  String? _validate(String? value,{bool required=false}) {
    if (value==null||value.trim().isEmpty) {
      return required ? 'This field is required.' : null;
    }
    return double.tryParse(value.trim())==null ? 'Enter a valid number.' : null;
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
            Text('Pricing', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height:20),
            TextFormField(
              controller: sellingPriceController,
              keyboardType: const TextInputType.numberWithOptions(decimal:true),
              decoration: const InputDecoration(
                labelText:'Selling Price',
                prefixIcon: Icon(Icons.currency_rupee),
              ),
              validator:(v)=>_validate(v,required:true),
            ),
            const SizedBox(height:16),
            TextFormField(
              controller: mrpController,
              keyboardType: const TextInputType.numberWithOptions(decimal:true),
              decoration: const InputDecoration(
                labelText:'MRP',
                prefixIcon: Icon(Icons.sell_outlined),
              ),
              validator:_validate,
            ),
            const SizedBox(height:16),
            TextFormField(
              controller: costPriceController,
              keyboardType: const TextInputType.numberWithOptions(decimal:true),
              decoration: const InputDecoration(
                labelText:'Cost Price',
                prefixIcon: Icon(Icons.account_balance_wallet_outlined),
              ),
              validator:_validate,
            ),
          ],
        ),
      ),
    );
  }
}

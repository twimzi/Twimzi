import 'package:flutter/material.dart';

class ServiceStep2 extends StatefulWidget {
  const ServiceStep2({super.key});

  @override
  State<ServiceStep2> createState() => _ServiceStep2State();
}

class _ServiceStep2State extends State<ServiceStep2> {
  final _formKey = GlobalKey<FormState>();

  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _durationController = TextEditingController(
    text: '30',
  );

  String _pricingType = 'Fixed';

  bool _taxIncluded = false;

  final List<String> _pricingTypes = const [
    'Fixed',
    'Hourly',
    'Daily',
    'Weekly',
    'Monthly',
    'Custom',
  ];

  @override
  void dispose() {
    _priceController.dispose();
    _discountController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _priceController,
              keyboardType:
              const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Service Price',
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter service price';
                }

                final price = double.tryParse(value);

                if (price == null || price < 0) {
                  return 'Invalid price';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: _pricingType,
              decoration: const InputDecoration(
                labelText: 'Pricing Type',
                border: OutlineInputBorder(),
              ),
              items: _pricingTypes
                  .map(
                    (type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _pricingType = value;
                });
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Duration (Minutes)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter duration';
                }

                final duration = int.tryParse(value);

                if (duration == null ||
                    duration <= 0) {
                  return 'Invalid duration';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _discountController,
              keyboardType:
              const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Discount (%)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Tax Included',
              ),
              subtitle: const Text(
                'Price already includes GST/Tax',
              ),
              value: _taxIncluded,
              onChanged: (value) {
                setState(() {
                  _taxIncluded = value;
                });
              },
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.attach_money),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Choose how customers are charged for this service. Fixed pricing works best for most local businesses.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
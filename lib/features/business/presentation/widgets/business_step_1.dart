import 'package:flutter/material.dart';

class BusinessStep1 extends StatefulWidget {
  const BusinessStep1({super.key});

  @override
  State<BusinessStep1> createState() => _BusinessStep1State();
}

class _BusinessStep1State extends State<BusinessStep1> {
  final _businessNameController = TextEditingController();
  final _taglineController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _businessType;
  String? _category;

  final List<String> businessTypes = const [
    'Retail',
    'Service',
    'Manufacturer',
    'Wholesaler',
    'Distributor',
    'Professional',
    'Restaurant',
    'Hotel',
    'Healthcare',
    'Education',
    'Other',
  ];

  final List<String> categories = const [
    'Electronics',
    'Fashion',
    'Agriculture',
    'Food',
    'Automobile',
    'Home Services',
    'Medical',
    'Education',
    'Beauty',
    'Construction',
    'Other',
  ];

  @override
  void dispose() {
    _businessNameController.dispose();
    _taglineController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  InputDecoration decoration(
      String label,
      IconData icon,
      ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Business Information',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Tell customers about your business.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 30),
        TextField(
          controller: _businessNameController,
          decoration: decoration(
            'Business Name',
            Icons.store,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _taglineController,
          decoration: decoration(
            'Tagline',
            Icons.short_text,
          ),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          initialValue: _businessType,
          decoration: decoration(
            'Business Type',
            Icons.business,
          ),
          items: businessTypes
              .map(
                (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
              .toList(),
          onChanged: (value) {
            setState(() {
              _businessType = value;
            });
          },
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          initialValue: _category,
          decoration: decoration(
            'Category',
            Icons.category,
          ),
          items: categories
              .map(
                (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
              .toList(),
          onChanged: (value) {
            setState(() {
              _category = value;
            });
          },
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _descriptionController,
          maxLines: 6,
          decoration: decoration(
            'Business Description',
            Icons.description,
          ),
        ),
        const SizedBox(height: 30),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.orange,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Choose a clear business name and write a short description so customers can easily find your business.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
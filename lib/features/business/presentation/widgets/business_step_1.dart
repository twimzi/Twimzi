import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/business_registration_provider.dart';

class BusinessStep1 extends ConsumerStatefulWidget {
  const BusinessStep1({super.key});

  @override
  ConsumerState<BusinessStep1> createState() => _BusinessStep1State();
}

class _BusinessStep1State extends ConsumerState<BusinessStep1> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _businessNameController;
  late final TextEditingController _taglineController;
  late final TextEditingController _descriptionController;

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
  void initState() {
    super.initState();

    final state = ref.read(businessRegistrationProvider);

    _businessNameController = TextEditingController(
      text: state.businessName,
    );

    _taglineController = TextEditingController(
      text: state.tagline,
    );

    _descriptionController = TextEditingController(
      text: state.description,
    );

    _businessType =
    state.businessType.isEmpty ? null : state.businessType;

    _category =
    state.category.isEmpty ? null : state.category;

    _businessNameController.addListener(_saveData);
    _taglineController.addListener(_saveData);
    _descriptionController.addListener(_saveData);
  }

  @override
  void dispose() {
    _businessNameController.removeListener(_saveData);
    _taglineController.removeListener(_saveData);
    _descriptionController.removeListener(_saveData);

    _businessNameController.dispose();
    _taglineController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  void _saveData() {
    if (_businessType == null || _category == null) {
      return;
    }

    ref
        .read(businessRegistrationProvider.notifier)
        .updateBusinessInfo(
      businessName: _businessNameController.text.trim(),
      tagline: _taglineController.text.trim(),
      description: _descriptionController.text.trim(),
      businessType: _businessType!,
      category: _category!,
    );
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
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _businessNameController,
            decoration: decoration(
              'Business Name',
              Icons.business,
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Business name is required';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          TextFormField(
            controller: _taglineController,
            decoration: decoration(
              'Tagline',
              Icons.short_text,
            ),
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: 16),

          TextFormField(
            controller: _descriptionController,
            decoration: decoration(
              'Description',
              Icons.description,
            ),
            minLines: 4,
            maxLines: 6,
            textInputAction: TextInputAction.newline,
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            initialValue: _businessType,
            decoration: decoration(
              'Business Type',
              Icons.category,
            ),
            items: businessTypes
                .map(
                  (type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              ),
            )
                .toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select business type';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _businessType = value;
              });

              _saveData();
            },
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            initialValue: _category,
            decoration: decoration(
              'Category',
              Icons.apps,
            ),
            items: categories
                .map(
                  (category) => DropdownMenuItem(
                value: category,
                child: Text(category),
              ),
            )
                .toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select category';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _category = value;
              });

              _saveData();
            },
          ),

          const SizedBox(height: 24),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      child: Icon(Icons.store),
                    ),
                    title: Text(
                      _businessNameController.text.isEmpty
                          ? 'Business Name'
                          : _businessNameController.text,
                    ),
                    subtitle: Text(
                      _taglineController.text.isEmpty
                          ? 'Business Tagline'
                          : _taglineController.text,
                    ),
                  ),

                  const Divider(),

                  Row(
                    children: [
                      const Icon(
                        Icons.category,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _businessType ?? 'Business Type',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.apps,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _category ?? 'Category',
                        ),
                      ),
                    ],
                  ),

                  if (_descriptionController.text.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Divider(),
                    Text(
                      _descriptionController.text,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: const [
              Icon(
                Icons.info_outline,
                size: 18,
                color: Colors.grey,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'You can edit these details later from your Business Dashboard.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

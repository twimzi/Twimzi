import 'package:flutter/material.dart';

class ServiceStep1 extends StatefulWidget {
  const ServiceStep1({super.key});

  @override
  State<ServiceStep1> createState() => _ServiceStep1State();
}

class _ServiceStep1State extends State<ServiceStep1> {
  final _formKey = GlobalKey<FormState>();

  final _serviceNameController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _categoryId;

  final List<DropdownMenuItem<String>> _categories = const [
    DropdownMenuItem(
      value: 'consulting',
      child: Text('Consulting'),
    ),
    DropdownMenuItem(
      value: 'repair',
      child: Text('Repair'),
    ),
    DropdownMenuItem(
      value: 'cleaning',
      child: Text('Cleaning'),
    ),
    DropdownMenuItem(
      value: 'education',
      child: Text('Education'),
    ),
    DropdownMenuItem(
      value: 'health',
      child: Text('Health'),
    ),
    DropdownMenuItem(
      value: 'beauty',
      child: Text('Beauty'),
    ),
    DropdownMenuItem(
      value: 'other',
      child: Text('Other'),
    ),
  ];

  @override
  void dispose() {
    _serviceNameController.dispose();
    _shortDescriptionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _serviceNameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Service Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter service name';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: _categoryId,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: _categories,
              onChanged: (value) {
                setState(() {
                  _categoryId = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select category';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller:
              _shortDescriptionController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Short Description',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter short description';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller:
              _descriptionController,
              minLines: 5,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter description';
                }

                return null;
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
                    const Icon(Icons.info_outline),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Provide a clear service name and detailed description so customers can easily understand what you offer.',
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
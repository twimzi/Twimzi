import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/business_registration_provider.dart';

class BusinessStep2 extends ConsumerStatefulWidget {
  const BusinessStep2({super.key});

  @override
  ConsumerState<BusinessStep2> createState() => _BusinessStep2State();
}

class _BusinessStep2State extends ConsumerState<BusinessStep2> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _countryController;
  late final TextEditingController _postalController;

  @override
  void initState() {
    super.initState();

    final registration = ref.read(businessRegistrationProvider);

    _addressController = TextEditingController(
      text: registration.address,
    );

    _cityController = TextEditingController(
      text: registration.city,
    );

    _stateController = TextEditingController(
      text: registration.state,
    );

    _countryController = TextEditingController(
      text: registration.country,
    );

    _postalController = TextEditingController(
      text: registration.postalCode,
    );

    _addressController.addListener(_saveData);
    _cityController.addListener(_saveData);
    _stateController.addListener(_saveData);
    _countryController.addListener(_saveData);
    _postalController.addListener(_saveData);
  }

  @override
  void dispose() {
    _addressController.removeListener(_saveData);
    _cityController.removeListener(_saveData);
    _stateController.removeListener(_saveData);
    _countryController.removeListener(_saveData);
    _postalController.removeListener(_saveData);

    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postalController.dispose();

    super.dispose();
  }

  void _saveData() {
    ref.read(businessRegistrationProvider.notifier).updateLocation(
      address: _addressController.text.trim(),
      city: _cityController.text.trim(),
      stateName: _stateController.text.trim(),
      country: _countryController.text.trim(),
      postalCode: _postalController.text.trim(),
    );

    setState(() {});
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
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Business Location',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Help customers find your business.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 30),

          TextFormField(
            controller: _addressController,
            maxLines: 3,
            decoration: decoration(
              'Business Address',
              Icons.location_on,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Business address is required';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _cityController,
            decoration: decoration(
              'City',
              Icons.location_city,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'City is required';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _stateController,
            decoration: decoration(
              'State',
              Icons.map,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'State is required';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _countryController,
            decoration: decoration(
              'Country',
              Icons.public,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Country is required';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _postalController,
            keyboardType: TextInputType.number,
            decoration: decoration(
              'Postal Code',
              Icons.pin_drop,
            ),
          ),

          const SizedBox(height: 30),

          OutlinedButton.icon(
            onPressed: () {
              // Future:
              // Google Maps
              // GPS
              // Reverse Geocoding
            },
            icon: const Icon(Icons.my_location),
            label: const Text(
              'Use Current Location',
            ),
          ),

          const SizedBox(height: 30),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preview',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(_addressController.text),
                  if (_cityController.text.isNotEmpty)
                    Text(_cityController.text),
                  if (_stateController.text.isNotEmpty)
                    Text(_stateController.text),
                  if (_countryController.text.isNotEmpty)
                    Text(_countryController.text),
                  if (_postalController.text.isNotEmpty)
                    Text(_postalController.text),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Accurate location improves local search visibility and helps nearby customers discover your business more easily.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
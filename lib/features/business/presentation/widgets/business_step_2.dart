import 'package:flutter/material.dart';

class BusinessStep2 extends StatefulWidget {
  const BusinessStep2({super.key});

  @override
  State<BusinessStep2> createState() => _BusinessStep2State();
}

class _BusinessStep2State extends State<BusinessStep2> {
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _postalController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postalController.dispose();
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
          "Business Location",
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        const SizedBox(height: 8),

        Text(
          "Help customers find your business.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 30),

        TextField(
          controller: _addressController,
          maxLines: 3,
          decoration: decoration(
            "Business Address",
            Icons.location_on,
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _cityController,
          decoration: decoration(
            "City",
            Icons.location_city,
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _stateController,
          decoration: decoration(
            "State",
            Icons.map,
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _countryController,
          decoration: decoration(
            "Country",
            Icons.public,
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _postalController,
          keyboardType: TextInputType.number,
          decoration: decoration(
            "Postal Code",
            Icons.pin_drop,
          ),
        ),

        const SizedBox(height: 30),

        OutlinedButton.icon(
          onPressed: () {
            // Google Maps / GPS integration
            // Will be connected later
          },
          icon: const Icon(Icons.my_location),
          label: const Text(
            "Use Current Location",
          ),
        ),

        const SizedBox(height: 30),

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
                    "Accurate location improves local search visibility and helps nearby customers discover your business more easily.",
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
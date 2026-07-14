import 'package:flutter/material.dart';

class BusinessStep5 extends StatefulWidget {
  const BusinessStep5({super.key});

  @override
  State<BusinessStep5> createState() => _BusinessStep5State();
}

class _BusinessStep5State extends State<BusinessStep5> {
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Review & Submit',
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        const SizedBox(height: 10),

        Text(
          'Please review your business information before submitting.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 30),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ListTile(
                  leading: Icon(Icons.store),
                  title: Text('Business Information'),
                  subtitle: Text(
                    'Business Name, Category, Type, Description',
                  ),
                ),
                Divider(),

                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Location'),
                  subtitle: Text(
                    'Address, City, State, Country',
                  ),
                ),
                Divider(),

                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Contact'),
                  subtitle: Text(
                    'Phone, WhatsApp, Email, Website',
                  ),
                ),
                Divider(),

                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Branding'),
                  subtitle: Text(
                    'Logo & Cover Image',
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 25),

        CheckboxListTile(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text(
            'I confirm that the information provided is accurate and I agree to the Terms & Conditions and Privacy Policy.',
          ),
        ),

        const SizedBox(height: 25),

        FilledButton.icon(
          onPressed: _acceptTerms
              ? () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Business registration will be connected to Supabase in the next step.',
                ),
              ),
            );
          }
              : null,
          icon: const Icon(Icons.check_circle),
          label: const Text(
            'Submit Business',
          ),
        ),

        const SizedBox(height: 20),

        Card(
          color: Colors.green.shade50,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.security,
                  color: Colors.green,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'After submission, your business profile will be created and available for further setup such as products, services, offers, gallery, and verification.',
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
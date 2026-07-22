import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/business_registration_provider.dart';

class BusinessStep5 extends ConsumerStatefulWidget {
  const BusinessStep5({super.key});

  @override
  ConsumerState<BusinessStep5> createState() => _BusinessStep5State();
}

class _BusinessStep5State extends ConsumerState<BusinessStep5> {
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    final registration = ref.watch(businessRegistrationProvider);

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
              children: [
                ListTile(
                  leading: const Icon(Icons.store),
                  title: const Text('Business Information'),
                  subtitle: Text(
                    '${registration.businessName}\n'
                        '${registration.businessType} • ${registration.category}\n'
                        '${registration.tagline}',
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Location'),
                  subtitle: Text(
                    '${registration.address}\n'
                        '${registration.city}, ${registration.state}\n'
                        '${registration.country} ${registration.postalCode}',
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Contact'),
                  subtitle: Text(
                    'Phone: ${registration.phone}\n'
                        'WhatsApp: ${registration.whatsapp}\n'
                        'Email: ${registration.email}\n'
                        'Website: ${registration.website}',
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Branding'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        registration.logo != null
                            ? '✓ Logo Selected'
                            : '✗ Logo Not Selected',
                      ),
                      Text(
                        registration.coverImage != null
                            ? '✓ Cover Selected'
                            : '✗ Cover Not Selected',
                      ),
                      Text(
                        '${registration.galleryImages.length} Gallery Images',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 25),

        CheckboxListTile(
          value: _acceptTerms,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text(
            'I confirm that the information provided is accurate and I agree to the Terms & Conditions and Privacy Policy.',
          ),
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
        ),

        const SizedBox(height: 25),

        FilledButton.icon(
          icon: registration.isSubmitting
              ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : const Icon(Icons.check_circle),
          label: Text(
            registration.isSubmitting
                ? 'Creating Business...'
                : 'Submit Business',
          ),
          onPressed: !_acceptTerms || registration.isSubmitting
              ? null
              : () async {
            try {
              final businessId = await ref
                  .read(businessRegistrationProvider.notifier)
                  .submitBusiness();

              if (!context.mounted) return;

              if (businessId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please complete all required information.',
                    ),
                  ),
                );
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Business created successfully.',
                  ),
                ),
              );

              ref
                  .read(businessRegistrationProvider.notifier)
                  .reset();

              Navigator.pop(context);
            } catch (e) {
              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    e.toString(),
                  ),
                ),
              );
            }
          },
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
                    'After submission, your business profile will be created. You can later add products, services, gallery, offers, verification documents and additional business details.',
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

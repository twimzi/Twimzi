import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/business_registration_provider.dart';

class BusinessStep3 extends ConsumerStatefulWidget {
  const BusinessStep3({super.key});

  @override
  ConsumerState<BusinessStep3> createState() => _BusinessStep3State();
}

class _BusinessStep3State extends ConsumerState<BusinessStep3> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _phoneController;
  late final TextEditingController _whatsappController;
  late final TextEditingController _emailController;
  late final TextEditingController _websiteController;

  late final TextEditingController _facebookController;
  late final TextEditingController _instagramController;
  late final TextEditingController _youtubeController;

  @override
  void initState() {
    super.initState();

    final registration = ref.read(businessRegistrationProvider);

    _phoneController = TextEditingController(
      text: registration.phone,
    );

    _whatsappController = TextEditingController(
      text: registration.whatsapp,
    );

    _emailController = TextEditingController(
      text: registration.email,
    );

    _websiteController = TextEditingController(
      text: registration.website,
    );

    _facebookController = TextEditingController(
      text: registration.facebook,
    );

    _instagramController = TextEditingController(
      text: registration.instagram,
    );

    _youtubeController = TextEditingController(
      text: registration.youtube,
    );

    _phoneController.addListener(_saveData);
    _whatsappController.addListener(_saveData);
    _emailController.addListener(_saveData);
    _websiteController.addListener(_saveData);
    _facebookController.addListener(_saveData);
    _instagramController.addListener(_saveData);
    _youtubeController.addListener(_saveData);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_saveData);
    _whatsappController.removeListener(_saveData);
    _emailController.removeListener(_saveData);
    _websiteController.removeListener(_saveData);
    _facebookController.removeListener(_saveData);
    _instagramController.removeListener(_saveData);
    _youtubeController.removeListener(_saveData);

    _phoneController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    _youtubeController.dispose();

    super.dispose();
  }

  void _saveData() {
    ref.read(businessRegistrationProvider.notifier).updateContact(
      phone: _phoneController.text.trim(),
      whatsapp: _whatsappController.text.trim(),
      email: _emailController.text.trim(),
      website: _websiteController.text.trim(),
      facebook: _facebookController.text.trim(),
      instagram: _instagramController.text.trim(),
      youtube: _youtubeController.text.trim(),
    );

    setState(() {});
  }

  InputDecoration inputDecoration(
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
            'Business Contact',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Customers will use these details to reach your business.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 30),

          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: inputDecoration(
              'Business Phone',
              Icons.phone,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Phone number is required';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _whatsappController,
            keyboardType: TextInputType.phone,
            decoration: inputDecoration(
              'WhatsApp Number',
              Icons.chat,
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: inputDecoration(
              'Business Email',
              Icons.email,
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _websiteController,
            keyboardType: TextInputType.url,
            decoration: inputDecoration(
              'Website',
              Icons.language,
            ),
          ),

          const SizedBox(height: 35),

          const Divider(),

          const SizedBox(height: 15),

          Text(
            'Social Media',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _facebookController,
            decoration: inputDecoration(
              'Facebook',
              Icons.facebook,
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _instagramController,
            decoration: inputDecoration(
              'Instagram',
              Icons.camera_alt,
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _youtubeController,
            decoration: inputDecoration(
              'YouTube',
              Icons.play_circle_fill,
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
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_phoneController.text.isNotEmpty)
                    Text('Phone: ${_phoneController.text}'),
                  if (_whatsappController.text.isNotEmpty)
                    Text('WhatsApp: ${_whatsappController.text}'),
                  if (_emailController.text.isNotEmpty)
                    Text('Email: ${_emailController.text}'),
                  if (_websiteController.text.isNotEmpty)
                    Text('Website: ${_websiteController.text}'),
                  if (_facebookController.text.isNotEmpty)
                    Text('Facebook: ${_facebookController.text}'),
                  if (_instagramController.text.isNotEmpty)
                    Text('Instagram: ${_instagramController.text}'),
                  if (_youtubeController.text.isNotEmpty)
                    Text('YouTube: ${_youtubeController.text}'),
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
                    Icons.campaign,
                    color: Colors.red,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Adding contact details and social media links increases customer trust and makes your business easier to reach.',
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
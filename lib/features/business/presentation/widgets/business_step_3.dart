import 'package:flutter/material.dart';

class BusinessStep3 extends StatefulWidget {
  const BusinessStep3({super.key});

  @override
  State<BusinessStep3> createState() => _BusinessStep3State();
}

class _BusinessStep3State extends State<BusinessStep3> {
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();

  final _facebookController = TextEditingController();
  final _instagramController = TextEditingController();
  final _youtubeController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
    _websiteController.dispose();

    _facebookController.dispose();
    _instagramController.dispose();
    _youtubeController.dispose();

    super.dispose();
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
    return ListView(
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

        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: inputDecoration(
            'Business Phone',
            Icons.phone,
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _whatsappController,
          keyboardType: TextInputType.phone,
          decoration: inputDecoration(
            'WhatsApp Number',
            Icons.chat,
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: inputDecoration(
            'Business Email',
            Icons.email,
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _websiteController,
          keyboardType: TextInputType.url,
          decoration: inputDecoration(
            'Website',
            Icons.language,
          ),
        ),

        const SizedBox(height: 35),

        Divider(),

        const SizedBox(height: 15),

        Text(
          'Social Media',
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _facebookController,
          decoration: inputDecoration(
            'Facebook',
            Icons.facebook,
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: _instagramController,
          decoration: inputDecoration(
            'Instagram',
            Icons.camera_alt,
          ),
        ),

        const SizedBox(height: 20),

        TextField(
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
    );
  }
}
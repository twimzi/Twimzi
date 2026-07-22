import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/business_registration_provider.dart';

class BusinessStep4 extends ConsumerStatefulWidget {
  const BusinessStep4({super.key});

  @override
  ConsumerState<BusinessStep4> createState() => _BusinessStep4State();
}

class _BusinessStep4State extends ConsumerState<BusinessStep4> {
  final ImagePicker _picker = ImagePicker();

  File? _logo;
  File? _cover;

  @override
  void initState() {
    super.initState();

    final registration = ref.read(businessRegistrationProvider);

    _logo = registration.logo;
    _cover = registration.coverImage;
  }

  Future<void> _pickLogo() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return;

    setState(() {
      _logo = File(image.path);
    });

    _saveImages();
  }

  Future<void> _pickCover() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return;

    setState(() {
      _cover = File(image.path);
    });

    _saveImages();
  }

  void _saveImages() {
    ref.read(businessRegistrationProvider.notifier).updateImages(
      logo: _logo,
      coverImage: _cover,
    );
  }

  Widget buildImageCard({
    required String title,
    required File? image,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 180,
          child: image != null
              ? Image.file(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
              ),
              const SizedBox(height: 12),
              Text(title),
              const SizedBox(height: 8),
              const Text(
                'Tap to select image',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Branding',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Upload your business logo and cover image.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 30),

        buildImageCard(
          title: 'Business Logo',
          image: _logo,
          onTap: _pickLogo,
          icon: Icons.storefront,
        ),

        const SizedBox(height: 25),

        buildImageCard(
          title: 'Cover Image',
          image: _cover,
          onTap: _pickCover,
          icon: Icons.photo,
        ),

        const SizedBox(height: 30),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.storefront),
                  title: const Text('Logo'),
                  subtitle: Text(
                    _logo == null
                        ? 'Not selected'
                        : _logo!.path.split('/').last,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Cover Image'),
                  subtitle: Text(
                    _cover == null
                        ? 'Not selected'
                        : _cover!.path.split('/').last,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.lightbulb,
                  color: Colors.amber,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Use a square logo with a transparent background and a high-quality cover image to make your business profile look professional.',
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
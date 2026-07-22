import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ServiceStep3 extends StatefulWidget {
  const ServiceStep3({super.key});

  @override
  State<ServiceStep3> createState() => _ServiceStep3State();
}

class _ServiceStep3State extends State<ServiceStep3> {
  final ImagePicker _picker = ImagePicker();

  File? _thumbnail;

  final List<File> _galleryImages = [];

  Future<void> _pickThumbnail() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return;

    setState(() {
      _thumbnail = File(image.path);
    });
  }

  Future<void> _pickGalleryImages() async {
    final images = await _picker.pickMultiImage(
      imageQuality: 85,
    );

    if (images.isEmpty) return;

    setState(() {
      _galleryImages.addAll(
        images.map((e) => File(e.path)),
      );
    });
  }

  void _removeGalleryImage(int index) {
    setState(() {
      _galleryImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            'Thumbnail',
            style:
            Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 12),

          InkWell(
            onTap: _pickThumbnail,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius:
                BorderRadius.circular(12),
              ),
              child: _thumbnail == null
                  ? const Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    size: 48,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Select Thumbnail',
                  ),
                ],
              )
                  : ClipRRect(
                borderRadius:
                BorderRadius.circular(12),
                child: Image.file(
                  _thumbnail!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 28),

          Row(
            children: [
              Text(
                'Gallery Images',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: _pickGalleryImages,
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          if (_galleryImages.isEmpty)
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius:
                BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'No gallery images selected',
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              itemCount: _galleryImages.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(
                          12,
                        ),
                        child: Image.file(
                          _galleryImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor:
                        Colors.black54,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 14,
                          color: Colors.white,
                          onPressed: () =>
                              _removeGalleryImage(
                                index,
                              ),
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

          const SizedBox(height: 28),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.cloud_upload_outlined,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'These images will be uploaded to Cloudflare R2 when the service is created. Use clear, high-quality images to improve customer engagement.',
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
    );
  }
}
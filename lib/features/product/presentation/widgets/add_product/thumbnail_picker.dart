import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ThumbnailPicker extends StatefulWidget {
  const ThumbnailPicker({
    super.key,
    required this.onChanged,
    this.initialImage,
    this.enabled = true,
  });

  final File? initialImage;
  final ValueChanged<File?> onChanged;
  final bool enabled;

  @override
  State<ThumbnailPicker> createState() =>
      _ThumbnailPickerState();
}

class _ThumbnailPickerState
    extends State<ThumbnailPicker> {
  final ImagePicker _picker = ImagePicker();

  File? _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _image = widget.initialImage;
  }

  Future<void> _pickImage(
      ImageSource source,
      ) async {
    if (!widget.enabled || _loading) {
      return;
    }

    try {
      setState(() {
        _loading = true;
      });

      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (picked == null) {
        return;
      }

      final file = File(picked.path);

      if (!mounted) {
        return;
      }

      setState(() {
        _image = file;
      });

      widget.onChanged(file);
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _showPicker() async {
    if (!widget.enabled) {
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                ),
                title: const Text(
                  'Choose from Gallery',
                ),
                onTap: () {
                  Navigator.pop(context);

                  _pickImage(
                    ImageSource.gallery,
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_outlined,
                ),
                title: const Text(
                  'Take Photo',
                ),
                onTap: () {
                  Navigator.pop(context);

                  _pickImage(
                    ImageSource.camera,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });

    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Thumbnail',
          style: Theme.of(context)
              .textTheme
              .titleMedium,
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: _showPicker,
          borderRadius:
          BorderRadius.circular(16),
          child: Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(16),
              border: Border.all(
                color:
                Theme.of(context)
                    .dividerColor,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (_image != null)
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(
                      16,
                    ),
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 56,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Tap to select thumbnail',
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Camera or Gallery',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ],
                  ),
                if (_loading)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius:
                      BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: const Center(
                      child:
                      CircularProgressIndicator(),
                    ),
                  ),
                if (_image != null &&
                    !_loading &&
                    widget.enabled)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Material(
                      color: Colors.red,
                      shape:
                      const CircleBorder(),
                      child: InkWell(
                        customBorder:
                        const CircleBorder(),
                        onTap: _removeImage,
                        child: const Padding(
                          padding:
                          EdgeInsets.all(8),
                          child: Icon(
                            Icons.close,
                            color:
                            Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
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
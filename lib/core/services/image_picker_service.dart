import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  ImagePickerService({
    ImagePicker? picker,
  }) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  /// Pick a single image from gallery.
  Future<File?> pickImageFromGallery() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  /// Pick a single image from camera.
  Future<File?> pickImageFromCamera() async {
    final image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
    );

    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  /// Pick multiple images.
  Future<List<File>> pickMultipleImages({
    int maxImages = 10,
  }) async {
    final images = await _picker.pickMultiImage(
      imageQuality: 90,
    );

    if (images.isEmpty) {
      return const [];
    }

    return images
        .take(maxImages)
        .map((image) => File(image.path))
        .toList();
  }

  /// Replace thumbnail.
  Future<File?> replaceThumbnail() async {
    return pickImageFromGallery();
  }

  /// Validate image size.
  Future<bool> isValidImage(
      File file, {
        int maxSizeInMB = 5,
      }) async {
    final bytes = await file.length();

    final sizeInMB = bytes / (1024 * 1024);

    return sizeInMB <= maxSizeInMB;
  }

  /// Remove duplicate image paths.
  List<File> removeDuplicates(
      List<File> files,
      ) {
    final unique = <String>{};

    return files.where((file) {
      if (unique.contains(file.path)) {
        return false;
      }

      unique.add(file.path);
      return true;
    }).toList();
  }

  /// Limit gallery images.
  List<File> limitImages(
      List<File> files, {
        int maxImages = 10,
      }) {
    return files.take(maxImages).toList();
  }
}
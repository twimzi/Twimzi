import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileStorageRepository {
  ProfileStorageRepository({
    SupabaseClient? client,
    ImagePicker? imagePicker,
  })  : _client = client ?? Supabase.instance.client,
        _imagePicker = imagePicker ?? ImagePicker();

  final SupabaseClient _client;
  final ImagePicker _imagePicker;

  static const String _bucketName = 'profile-images';

  User get currentUser {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in.');
    }

    return user;
  }

  Future<File?> pickFromGallery() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  Future<File?> pickFromCamera() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  Future<String> uploadProfilePhoto(File file) async {
    try {
      final extension = path.extension(file.path);

      final fileName =
          '${currentUser.id}_${DateTime.now().millisecondsSinceEpoch}$extension';

      final storagePath = '${currentUser.id}/$fileName';

      await _client.storage.from(_bucketName).upload(
        storagePath,
        file,
        fileOptions: const FileOptions(
          upsert: true,
        ),
      );

      return _client.storage.from(_bucketName).getPublicUrl(storagePath);
    } on StorageException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProfilePhoto(String imageUrl) async {
    try {
      final uri = Uri.parse(imageUrl);

      final segments = uri.pathSegments;

      final bucketIndex = segments.indexOf(_bucketName);

      if (bucketIndex == -1) {
        return;
      }

      final storagePath =
      segments.sublist(bucketIndex + 1).join('/');

      if (storagePath.isEmpty) {
        return;
      }

      await _client.storage
          .from(_bucketName)
          .remove([storagePath]);
    } catch (_) {
      // Ignore delete failures.
    }
  }

  Future<String> replaceProfilePhoto({
    required File file,
    String? oldImageUrl,
  }) async {
    if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
      await deleteProfilePhoto(oldImageUrl);
    }

    return uploadProfilePhoto(file);
  }
}
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'storage_repository.dart';

/// Supabase Storage implementation.
///
/// Replace only this class when migrating to Cloudflare R2.
/// The rest of the application should never know which
/// storage provider is being used.
class StorageService implements StorageRepository {
  StorageService({
    SupabaseClient? client,
    this.bucketName = 'product-images',
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;
  final String bucketName;

  @override
  Future<String> uploadImage({
    required File file,
    required String folder,
    String? fileName,
  }) async {
    final extension = path.extension(file.path);

    final generatedFileName =
        fileName ?? '${DateTime.now().millisecondsSinceEpoch}$extension';

    final storagePath = '$folder/$generatedFileName';

    await _client.storage.from(bucketName).upload(
      storagePath,
      file,
      fileOptions: const FileOptions(
        upsert: true,
      ),
    );

    return _client.storage.from(bucketName).getPublicUrl(storagePath);
  }

  @override
  Future<List<String>> uploadImages({
    required List<File> files,
    required String folder,
  }) async {
    final urls = <String>[];

    for (final file in files) {
      final url = await uploadImage(
        file: file,
        folder: folder,
      );

      urls.add(url);
    }

    return urls;
  }

  @override
  Future<void> deleteImage({
    required String imageUrl,
  }) async {
    if (imageUrl.isEmpty) {
      return;
    }

    final uri = Uri.parse(imageUrl);

    final index = uri.path.indexOf(bucketName);

    if (index == -1) {
      return;
    }

    final storagePath =
    uri.path.substring(index + bucketName.length + 1);

    await _client.storage
        .from(bucketName)
        .remove([storagePath]);
  }

  @override
  Future<void> deleteImages({
    required List<String> imageUrls,
  }) async {
    if (imageUrls.isEmpty) {
      return;
    }

    for (final url in imageUrls) {
      await deleteImage(
        imageUrl: url,
      );
    }
  }

  @override
  Future<String> replaceImage({
    required File newFile,
    required String? oldImageUrl,
    required String folder,
    String? fileName,
  }) async {
    if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
      await deleteImage(
        imageUrl: oldImageUrl,
      );
    }

    return uploadImage(
      file: newFile,
      folder: folder,
      fileName: fileName,
    );
  }

  @override
  String getProductFolder({
    required String businessId,
    required String productId,
  }) {
    return 'businesses/$businessId/products/$productId';
  }

  @override
  String getBusinessFolder({
    required String businessId,
  }) {
    return 'businesses/$businessId';
  }

  @override
  Future<void> deleteFolder({
    required String folder,
  }) async {
    final objects = await _client.storage
        .from(bucketName)
        .list(path: folder);

    if (objects.isEmpty) {
      return;
    }

    final paths = objects
        .map(
          (object) => '$folder/${object.name}',
    )
        .toList();

    await _client.storage
        .from(bucketName)
        .remove(paths);
  }
}
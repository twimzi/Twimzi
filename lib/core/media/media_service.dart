import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/storage_repository.dart';
import 'media_repository.dart';

class MediaService implements MediaRepository {
  MediaService({
    SupabaseClient? client,
    required StorageRepository storageRepository,
  })  : _client = client ?? Supabase.instance.client,
        _storage = storageRepository;

  final SupabaseClient _client;
  final StorageRepository _storage;

  @override
  Future<String> uploadMedia({
    required File file,
    required String folder,
    String? fileName,
    String? altText,
  }) async {
    // Upload file using existing storage layer.
    final publicUrl = await _storage.uploadImage(
      file: file,
      folder: folder,
      fileName: fileName,
    );

    final objectPath = Uri.parse(publicUrl).pathSegments
        .skipWhile((e) => e != 'product-images')
        .skip(1)
        .join('/');

    final inserted = await _client
        .from('media')
        .insert({
      'uploaded_by': _client.auth.currentUser?.id,
      'bucket_name': 'product-images',
      'object_path': objectPath,
      'file_name': path.basename(objectPath),
      'original_name': path.basename(file.path),
      'mime_type': _mimeType(file.path),
      'extension': path.extension(file.path).replaceFirst('.', ''),
      'file_size': await file.length(),
      'alt_text': altText,
      'is_public': true,
    })
        .select('id')
        .single();

    return inserted['id'] as String;
  }

  @override
  Future<List<String>> uploadMediaList({
    required List<File> files,
    required String folder,
  }) async {
    final ids = <String>[];

    for (final file in files) {
      ids.add(
        await uploadMedia(
          file: file,
          folder: folder,
        ),
      );
    }

    return ids;
  }

  @override
  Future<void> deleteMedia({
    required String mediaId,
  }) async {
    final media = await _client
        .from('media')
        .select()
        .eq('id', mediaId)
        .single();

    final bucket = media['bucket_name'] as String;
    final object = media['object_path'] as String;

    await _client.storage.from(bucket).remove([object]);

    await _client
        .from('media')
        .delete()
        .eq('id', mediaId);
  }

  @override
  Future<void> deleteMediaList({
    required List<String> mediaIds,
  }) async {
    for (final id in mediaIds) {
      await deleteMedia(mediaId: id);
    }
  }

  @override
  Future<String?> getMediaUrl({
    required String mediaId,
  }) async {
    final media = await _client
        .from('media')
        .select()
        .eq('id', mediaId)
        .maybeSingle();

    if (media == null) {
      return null;
    }

    return _client.storage
        .from(media['bucket_name'] as String)
        .getPublicUrl(
      media['object_path'] as String,
    );
  }

  String _mimeType(String filePath) {
    final ext = path.extension(filePath).toLowerCase();

    switch (ext) {
      case '.png':
        return 'image/png';
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.webp':
        return 'image/webp';
      default:
        return 'application/octet-stream';
    }
  }
}

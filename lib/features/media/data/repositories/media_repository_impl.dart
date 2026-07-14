import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'media_repository.dart';

class MediaRepositoryImpl implements MediaRepository {
  MediaRepositoryImpl({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  @override
  Future<MediaUploadResult> uploadImage({
    required File file,
    required String folder,
    required String uploadedBy,
    bool isPublic = true,
  }) async {
    final bytes = await file.readAsBytes();

    final response = await _client.functions.invoke(
      'upload-media',
      body: {
        'folder': folder,
        'uploadedBy': uploadedBy,
        'isPublic': isPublic,
        'fileName': file.uri.pathSegments.last,
        'bytes': bytes,
      },
    );

    if (response.status != 200) {
      throw Exception(
        response.data?['error'] ?? 'Upload failed.',
      );
    }

    return MediaUploadResult(
      mediaId: response.data['mediaId'] as String,
      objectPath: response.data['objectPath'] as String,
      publicUrl: response.data['publicUrl'] as String,
    );
  }

  @override
  Future<void> deleteMedia({
    required String mediaId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<String?> getPublicUrl({
    required String mediaId,
  }) async {
    throw UnimplementedError();
  }
}
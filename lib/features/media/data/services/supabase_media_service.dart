import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'media_service.dart';

class SupabaseMediaService implements MediaService {
  SupabaseMediaService({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  @override
  Future<MediaUploadResponse> upload({
    required File file,
    required String folder,
    required String uploadedBy,
    bool isPublic = true,
  }) async {
    final response = await _client.functions.invoke(
      'upload-media',
      body: {
        'folder': folder,
        'uploadedBy': uploadedBy,
        'isPublic': isPublic,
        'fileName': file.path.split('/').last,
        'fileBytes': await file.readAsBytes(),
      },
    );

    if (response.status != 200) {
      throw Exception(
        response.data['error'] ?? 'Media upload failed.',
      );
    }

    return MediaUploadResponse(
      mediaId: response.data['mediaId'] as String,
      objectPath: response.data['objectPath'] as String,
      publicUrl: response.data['publicUrl'] as String,
    );
  }

  @override
  Future<void> delete({
    required String mediaId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<String?> getUrl({
    required String mediaId,
  }) async {
    throw UnimplementedError();
  }
}
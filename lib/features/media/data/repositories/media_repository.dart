import 'dart:io';

class MediaUploadResult {
  final String mediaId;
  final String objectPath;
  final String publicUrl;

  const MediaUploadResult({
    required this.mediaId,
    required this.objectPath,
    required this.publicUrl,
  });
}

abstract class MediaRepository {
  Future<MediaUploadResult> uploadImage({
    required File file,
    required String folder,
    required String uploadedBy,
    bool isPublic = true,
  });

  Future<void> deleteMedia({
    required String mediaId,
  });

  Future<String?> getPublicUrl({
    required String mediaId,
  });
}
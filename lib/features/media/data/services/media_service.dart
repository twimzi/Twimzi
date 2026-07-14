import 'dart:io';

abstract class MediaService {
  Future<MediaUploadResponse> upload({
    required File file,
    required String folder,
    required String uploadedBy,
    bool isPublic = true,
  });

  Future<void> delete({
    required String mediaId,
  });

  Future<String?> getUrl({
    required String mediaId,
  });
}

class MediaUploadResponse {
  final String mediaId;
  final String objectPath;
  final String publicUrl;

  const MediaUploadResponse({
    required this.mediaId,
    required this.objectPath,
    required this.publicUrl,
  });
}
import 'dart:io';

/// Repository for Media Library.
///
/// Responsible for:
/// - Uploading files
/// - Creating media records
/// - Returning media IDs
/// - Deleting media
///
/// Unlike StorageRepository, this repository works with the
/// normalized media database.
abstract class MediaRepository {
  const MediaRepository();

  /// Uploads a single file and returns the created media ID.
  Future<String> uploadMedia({
    required File file,
    required String folder,
    String? fileName,
    String? altText,
  });

  /// Uploads multiple files and returns media IDs.
  Future<List<String>> uploadMediaList({
    required List<File> files,
    required String folder,
  });

  /// Deletes a media record and its storage object.
  Future<void> deleteMedia({
    required String mediaId,
  });

  /// Deletes multiple media records.
  Future<void> deleteMediaList({
    required List<String> mediaIds,
  });

  /// Returns the public URL for a media item.
  Future<String?> getMediaUrl({
    required String mediaId,
  });
}
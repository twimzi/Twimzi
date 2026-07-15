import 'dart:io';

/// Storage abstraction for Twimzi.
///
/// This interface isolates the application from the underlying
/// storage provider (Supabase Storage, Cloudflare R2, AWS S3, etc.).
///
/// The rest of the application must depend only on this interface.
abstract class StorageRepository {
  const StorageRepository();

  /// Uploads a single image and returns its public URL.
  Future<String> uploadImage({
    required File file,
    required String folder,
    String? fileName,
  });

  /// Uploads multiple images and returns their public URLs.
  Future<List<String>> uploadImages({
    required List<File> files,
    required String folder,
  });

  /// Deletes a previously uploaded image.
  Future<void> deleteImage({
    required String imageUrl,
  });

  /// Deletes multiple images.
  Future<void> deleteImages({
    required List<String> imageUrls,
  });

  /// Replaces an existing image and returns the new public URL.
  Future<String> replaceImage({
    required File newFile,
    required String? oldImageUrl,
    required String folder,
    String? fileName,
  });

  /// Generates the storage folder for a product.
  ///
  /// Example:
  /// businesses/{businessId}/products/{productId}
  String getProductFolder({
    required String businessId,
    required String productId,
  });

  /// Generates the storage folder for a business.
  ///
  /// Example:
  /// businesses/{businessId}
  String getBusinessFolder({
    required String businessId,
  });

  /// Deletes an entire folder and all of its files.
  Future<void> deleteFolder({
    required String folder,
  });
}
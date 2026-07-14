import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/media_service.dart';
import '../../data/services/supabase_media_service.dart';

final mediaServiceProvider = Provider<MediaService>(
      (ref) => SupabaseMediaService(),
);

final mediaProvider =
StateNotifierProvider<MediaNotifier, MediaState>(
      (ref) => MediaNotifier(
    ref.read(mediaServiceProvider),
  ),
);

class MediaNotifier extends StateNotifier<MediaState> {
  MediaNotifier(this._service)
      : super(const MediaState());

  final MediaService _service;

  Future<MediaUploadResponse> uploadImage({
    required File file,
    required String folder,
    required String uploadedBy,
    bool isPublic = true,
  }) async {
    try {
      state = state.copyWith(
        isUploading: true,
        error: null,
      );

      final result = await _service.upload(
        file: file,
        folder: folder,
        uploadedBy: uploadedBy,
        isPublic: isPublic,
      );

      state = state.copyWith(
        isUploading: false,
        lastUpload: result,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isUploading: false,
        error: e.toString(),
      );

      rethrow;
    }
  }

  void clear() {
    state = const MediaState();
  }
}

class MediaState {
  final bool isUploading;
  final String? error;
  final MediaUploadResponse? lastUpload;

  const MediaState({
    this.isUploading = false,
    this.error,
    this.lastUpload,
  });

  MediaState copyWith({
    bool? isUploading,
    String? error,
    MediaUploadResponse? lastUpload,
  }) {
    return MediaState(
      isUploading: isUploading ?? this.isUploading,
      error: error,
      lastUpload: lastUpload ?? this.lastUpload,
    );
  }
}
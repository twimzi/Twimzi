import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/profile_model.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/profile_storage_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final profileStorageRepositoryProvider =
Provider<ProfileStorageRepository>((ref) {
  return ProfileStorageRepository();
});

final profileProvider =
AsyncNotifierProvider<ProfileNotifier, ProfileModel?>(
  ProfileNotifier.new,
);

class ProfileNotifier extends AsyncNotifier<ProfileModel?> {
  late final ProfileRepository _repository;
  late final ProfileStorageRepository _storageRepository;

  @override
  Future<ProfileModel?> build() async {
    _repository = ref.read(profileRepositoryProvider);
    _storageRepository = ref.read(profileStorageRepositoryProvider);

    await _repository.createProfileIfNeeded();

    return _repository.getProfile();
  }

  Future<void> refreshProfile() async {
    state = const AsyncLoading<ProfileModel?>().copyWithPrevious(state);

    state = await AsyncValue.guard(
          () => _repository.getProfile(),
    );
  }

  Future<void> createProfile(ProfileModel profile) async {
    state = const AsyncLoading<ProfileModel?>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      await _repository.createProfile(profile);

      return _repository.getProfile();
    });
  }

  Future<void> updateProfile(ProfileModel profile) async {
    state = const AsyncLoading<ProfileModel?>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      await _repository.updateProfile(profile);

      return profile;
    });
  }

  Future<void> deleteProfile() async {
    state = const AsyncLoading<ProfileModel?>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      await _repository.deleteProfile();

      return null;
    });
  }

  Future<void> uploadProfilePhoto(File imageFile) async {
    final currentProfile = state.value;

    if (currentProfile == null) {
      throw Exception('Profile not found.');
    }

    state = const AsyncLoading<ProfileModel?>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      final imageUrl = await _storageRepository.replaceProfilePhoto(
        file: imageFile,
        oldImageUrl: currentProfile.profilePhotoUrl,
      );

      final updatedProfile = currentProfile.copyWith(
        profilePhotoUrl: imageUrl,
      );

      await _repository.updateProfile(updatedProfile);

      return updatedProfile;
    });
  }

  Future<void> removeProfilePhoto() async {
    final currentProfile = state.value;

    if (currentProfile == null) return;

    if (currentProfile.profilePhotoUrl != null &&
        currentProfile.profilePhotoUrl!.isNotEmpty) {
      await _storageRepository
          .deleteProfilePhoto(currentProfile.profilePhotoUrl!);
    }

    final updatedProfile = currentProfile.copyWith(
      profilePhotoUrl: null,
    );

    await _repository.updateProfile(updatedProfile);

    state = AsyncData(updatedProfile);
  }

  bool get isProfileCompleted {
    final profile = state.value;

    if (profile == null) return false;

    return (profile.fullName?.trim().isNotEmpty ?? false) &&
        (profile.username?.trim().isNotEmpty ?? false) &&
        (profile.phone?.trim().isNotEmpty ?? false) &&
        profile.gender != null &&
        profile.dateOfBirth != null;
  }

  Future<void> reload() async {
    state = await AsyncValue.guard(
          () => _repository.getProfile(),
    );
  }
}
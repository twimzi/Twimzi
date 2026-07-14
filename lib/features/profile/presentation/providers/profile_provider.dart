import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/profile_model.dart';
import '../../data/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final profileProvider =
AsyncNotifierProvider<ProfileNotifier, ProfileModel?>(
  ProfileNotifier.new,
);

class ProfileNotifier extends AsyncNotifier<ProfileModel?> {
  late final ProfileRepository _repository;

  @override
  Future<ProfileModel?> build() async {
    _repository = ref.read(profileRepositoryProvider);

    await _repository.createProfileIfNeeded();

    return await _repository.getProfile();
  }

  Future<void> refreshProfile() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
          () async => await _repository.getProfile(),
    );
  }

  Future<void> updateProfile(ProfileModel profile) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _repository.updateProfile(profile);

      return await _repository.getProfile();
    });
  }

  Future<void> createProfile(ProfileModel profile) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _repository.createProfile(profile);

      return await _repository.getProfile();
    });
  }

  Future<void> deleteProfile() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _repository.deleteProfile();

      return null;
    });
  }
}
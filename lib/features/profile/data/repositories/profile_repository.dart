import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile_model.dart';

class ProfileRepository {
  ProfileRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  User get currentUser {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in.');
    }

    return user;
  }

  Future<ProfileModel?> getProfile() async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', currentUser.id)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return ProfileModel.fromJson(response);
  }

  Future<void> createProfile(ProfileModel profile) async {
    await _client
        .from('profiles')
        .insert(profile.toJson());
  }

  Future<void> updateProfile(ProfileModel profile) async {
    await _client
        .from('profiles')
        .update(profile.toJson())
        .eq('id', currentUser.id);
  }

  Future<void> deleteProfile() async {
    await _client
        .from('profiles')
        .delete()
        .eq('id', currentUser.id);
  }

  Future<bool> profileExists() async {
    final response = await _client
        .from('profiles')
        .select('id')
        .eq('id', currentUser.id)
        .maybeSingle();

    return response != null;
  }

  Future<void> createProfileIfNeeded() async {
    final exists = await profileExists();

    if (exists) return;

    final user = currentUser;

    await createProfile(
      ProfileModel(
        id: user.id,
        fullName: user.userMetadata?['full_name'],
        email: user.email,
      ),
    );
  }
}
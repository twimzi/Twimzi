import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: profile.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        data: (user) {
          if (user == null) {
            return const Center(
              child: Text('Profile not found'),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(profileProvider.notifier).refreshProfile(),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                    user.profilePhotoUrl != null &&
                        user.profilePhotoUrl!.isNotEmpty
                        ? NetworkImage(user.profilePhotoUrl!)
                        : null,
                    child:
                    user.profilePhotoUrl == null ||
                        user.profilePhotoUrl!.isEmpty
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: Text(
                    user.fullName ?? 'Unnamed User',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),

                const SizedBox(height: 8),

                Center(
                  child: Text(
                    user.email ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                const SizedBox(height: 32),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(user.phone ?? '-'),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.badge),
                    title: const Text('Username'),
                    subtitle: Text(user.username ?? '-'),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Bio'),
                    subtitle: Text(user.bio ?? '-'),
                  ),
                ),

                const SizedBox(height: 30),

                FilledButton.icon(
                  onPressed: () {
                    // Edit Profile (next pack)
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
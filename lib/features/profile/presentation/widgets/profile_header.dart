import 'package:flutter/material.dart';

import '../../data/models/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;

  const ProfileHeader({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 52,
          backgroundImage: profile.profilePhotoUrl != null &&
              profile.profilePhotoUrl!.isNotEmpty
              ? NetworkImage(profile.profilePhotoUrl!)
              : null,
          child: profile.profilePhotoUrl == null ||
              profile.profilePhotoUrl!.isEmpty
              ? const Icon(
            Icons.person,
            size: 54,
          )
              : null,
        ),

        const SizedBox(height: 16),

        Text(
          profile.fullName ?? 'Unnamed User',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 6),

        Text(
          profile.email ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              profile.isVerified
                  ? Icons.verified
                  : Icons.verified_outlined,
              color: profile.isVerified
                  ? Colors.green
                  : Colors.grey,
            ),

            const SizedBox(width: 6),

            Text(
              profile.isVerified
                  ? 'Verified'
                  : 'Not Verified',
            ),
          ],
        ),
      ],
    );
  }
}
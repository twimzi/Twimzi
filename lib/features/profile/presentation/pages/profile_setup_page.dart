import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/profile_model.dart';
import '../../data/repositories/profile_storage_repository.dart';
import '../providers/profile_provider.dart';

class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ProfileSetupPage> createState() =>
      _ProfileSetupPageState();
}

class _ProfileSetupPageState
    extends ConsumerState<ProfileSetupPage> {
final _formKey = GlobalKey<FormState>();

late final TextEditingController _fullNameController;
late final TextEditingController _usernameController;
late final TextEditingController _phoneController;
late final TextEditingController _bioController;

String? _gender;
DateTime? _dob;
File? _selectedImage;

@override
void initState() {
super.initState();

_fullNameController = TextEditingController();
_usernameController = TextEditingController();
_phoneController = TextEditingController();
_bioController = TextEditingController();
}

@override
void dispose() {
_fullNameController.dispose();
_usernameController.dispose();
_phoneController.dispose();
_bioController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
final profileState = ref.watch(profileProvider);

ref.listen(profileProvider, (previous, next) {
next.whenOrNull(
data: (_) {
if (context.mounted) {
context.go('/home');
}
},
error: (error, _) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(error.toString()),
),
);
},
);
});

return Scaffold(
appBar: AppBar(
title: const Text('Complete Profile'),
),
body: profileState.when(
loading: () => const Center(
child: CircularProgressIndicator(),
),
error: (error, _) => Center(
child: Text(error.toString()),
),
data: (profile) {
_initialize(profile);

return SafeArea(
child: Form(
key: _formKey,
child: ListView(
padding: const EdgeInsets.all(20),
children: [
const SizedBox(height: 12),
Center(
child: Stack(
children: [
GestureDetector(
onTap: _showImagePicker,
child: CircleAvatar(
radius: 55,
backgroundImage: _selectedImage != null
? FileImage(_selectedImage!)
: (profile?.profilePhotoUrl != null &&
profile!.profilePhotoUrl!.isNotEmpty)
? NetworkImage(
profile.profilePhotoUrl!,
)
: null,
child: _selectedImage == null &&
(profile?.profilePhotoUrl == null ||
profile!.profilePhotoUrl!.isEmpty)
? const Icon(
Icons.person,
size: 50,
)
: null,
),
),
Positioned(
bottom: 0,
right: 0,
child: CircleAvatar(
radius: 18,
child: IconButton(
iconSize: 18,
padding: EdgeInsets.zero,
icon: const Icon(Icons.camera_alt),
onPressed: _showImagePicker,
),
),
),
],
),
),

const SizedBox(height: 24),

TextFormField(
controller: _fullNameController,
decoration: const InputDecoration(
labelText: 'Full Name',
),
validator: (value) {
if (value == null || value.trim().isEmpty) {
return 'Enter your full name';
}
return null;
},
),

const SizedBox(height: 16),

TextFormField(
controller: _usernameController,
decoration: const InputDecoration(
labelText: 'Username',
),
validator: (value) {
if (value == null || value.trim().isEmpty) {
return 'Username required';
}

if (value.trim().length < 4) {
return 'Minimum 4 characters';
}

return null;
},
),

const SizedBox(height: 16),

TextFormField(
controller: _phoneController,
keyboardType: TextInputType.phone,
decoration: const InputDecoration(
labelText: 'Phone Number',
),
validator: (value) {
if (value == null || value.trim().isEmpty) {
return 'Phone number required';
}

return null;
},
),

const SizedBox(height: 16),

DropdownButtonFormField<String>(
initialValue: _gender,
decoration: const InputDecoration(
labelText: 'Gender',
),
items: const [
DropdownMenuItem(
value: 'Male',
child: Text('Male'),
),
DropdownMenuItem(
value: 'Female',
child: Text('Female'),
),
DropdownMenuItem(
value: 'Other',
child: Text('Other'),
),
],
onChanged: (value) {
setState(() {
_gender = value;
});
},
),

const SizedBox(height: 16),
ListTile(
contentPadding: EdgeInsets.zero,
title: Text(
_dob == null
? 'Select Date of Birth'
: _dob!
.toLocal()
.toString()
.split(' ')
.first,
),
trailing: const Icon(Icons.calendar_today),
onTap: _pickDob,
),

const SizedBox(height: 16),

TextFormField(
controller: _bioController,
maxLines: 3,
decoration: const InputDecoration(
labelText: 'Bio',
alignLabelWithHint: true,
),
),

const SizedBox(height: 32),

FilledButton.icon(
onPressed: profileState.isLoading
? null
: () => _save(profile),
icon: profileState.isLoading
? const SizedBox(
width: 18,
height: 18,
child: CircularProgressIndicator(
strokeWidth: 2,
),
)
: const Icon(Icons.arrow_forward),
label: const Text('Continue'),
),

const SizedBox(height: 24),
],
),
),
);
},
),
);
}
void _initialize(ProfileModel? profile) {
  if (_fullNameController.text.isNotEmpty) return;

  _fullNameController.text = profile?.fullName ?? '';
  _usernameController.text = profile?.username ?? '';
  _phoneController.text = profile?.phone ?? '';
  _bioController.text = profile?.bio ?? '';

  _gender = profile?.gender;
  _dob = profile?.dateOfBirth;
}

Future<void> _pickDob() async {
  final picked = await showDatePicker(
    context: context,
    initialDate: _dob ?? DateTime(2000),
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
  );

  if (picked != null) {
    setState(() {
      _dob = picked;
    });
  }
}

Future<void> _showImagePicker() async {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);

                final repo = ProfileStorageRepository();

                final image = await repo.pickFromGallery();

                if (image != null) {
                  setState(() {
                    _selectedImage = image;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);

                final repo = ProfileStorageRepository();

                final image = await repo.pickFromCamera();

                if (image != null) {
                  setState(() {
                    _selectedImage = image;
                  });
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _save(ProfileModel? profile) async {
  if (!_formKey.currentState!.validate()) return;

  final updated = (profile ?? const ProfileModel(id: '')).copyWith(
    fullName: _fullNameController.text.trim(),
    username: _usernameController.text.trim(),
    phone: _phoneController.text.trim(),
    bio: _bioController.text.trim(),
    gender: _gender,
    dateOfBirth: _dob,
  );

  final notifier = ref.read(profileProvider.notifier);

  await notifier.updateProfile(updated);

  if (_selectedImage != null) {
    await notifier.uploadProfilePhoto(_selectedImage!);
  }

  if (mounted) {
    context.go('/home');
  }
}
}

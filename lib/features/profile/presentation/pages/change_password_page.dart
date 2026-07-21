import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() =>
      _ChangePasswordPageState();
}

class _ChangePasswordPageState
    extends ConsumerState<ChangePasswordPage> {
final _formKey = GlobalKey<FormState>();

final _currentPasswordController =
TextEditingController();

final _newPasswordController =
TextEditingController();

final _confirmPasswordController =
TextEditingController();

bool _obscureCurrent = true;
bool _obscureNew = true;
bool _obscureConfirm = true;

bool _isLoading = false;

@override
void dispose() {
_currentPasswordController.dispose();
_newPasswordController.dispose();
_confirmPasswordController.dispose();
super.dispose();
}

Future<void> _changePassword() async {
if (!_formKey.currentState!.validate()) {
return;
}

setState(() {
_isLoading = true;
});
try {
await ref
.read(authProvider.notifier)
.changePassword(
newPassword:
_newPasswordController.text.trim(),
);

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Password changed successfully.',
),
),
);

Navigator.pop(context);
} catch (e) {
if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
e.toString(),
),
),
);
} finally {
if (mounted) {
setState(() {
_isLoading = false;
});
}
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
'Change Password',
),
),
body: SafeArea(
child: Form(
key: _formKey,
child: ListView(
padding: const EdgeInsets.all(20),
children: [
const SizedBox(height: 20),

TextFormField(
controller:
_currentPasswordController,
obscureText: _obscureCurrent,
decoration: InputDecoration(
labelText: 'Current Password',
prefixIcon:
const Icon(Icons.lock),
suffixIcon: IconButton(
icon: Icon(
_obscureCurrent
? Icons.visibility
: Icons.visibility_off,
),
onPressed: () {
setState(() {
_obscureCurrent =
!_obscureCurrent;
});
},
),
),
validator: (value) {
if (value == null ||
value.isEmpty) {
return 'Current password is required';
}

return null;
},
),

const SizedBox(height: 20),
TextFormField(
controller: _newPasswordController,
obscureText: _obscureNew,
decoration: InputDecoration(
labelText: 'New Password',
prefixIcon: const Icon(Icons.lock_outline),
suffixIcon: IconButton(
icon: Icon(
_obscureNew
? Icons.visibility
: Icons.visibility_off,
),
onPressed: () {
setState(() {
_obscureNew = !_obscureNew;
});
},
),
),
validator: (value) {
if (value == null || value.isEmpty) {
return 'New password is required';
}

if (value.length < 8) {
return 'Password must be at least 8 characters';
}

return null;
},
),

const SizedBox(height: 20),

TextFormField(
controller: _confirmPasswordController,
obscureText: _obscureConfirm,
decoration: InputDecoration(
labelText: 'Confirm Password',
prefixIcon: const Icon(Icons.lock_reset),
suffixIcon: IconButton(
icon: Icon(
_obscureConfirm
? Icons.visibility
: Icons.visibility_off,
),
onPressed: () {
setState(() {
_obscureConfirm =
!_obscureConfirm;
});
},
),
),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please confirm your password';
}

if (value !=
_newPasswordController.text) {
return 'Passwords do not match';
}

return null;
},
),

const SizedBox(height: 32),

FilledButton.icon(
onPressed:
_isLoading ? null : _changePassword,
icon: _isLoading
? const SizedBox(
width: 18,
height: 18,
child: CircularProgressIndicator(
strokeWidth: 2,
),
)
: const Icon(Icons.save),
label: const Text(
'Update Password',
),
),

const SizedBox(height: 20),
],
),
),
),
);
}
}
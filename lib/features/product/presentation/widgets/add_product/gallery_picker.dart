import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPicker extends StatefulWidget {
  const GalleryPicker({
    super.key,
    required this.onChanged,
    this.initialImages = const [],
    this.enabled = true,
    this.maxImages = 10,
  });

  final List<File> initialImages;
  final ValueChanged<List<File>> onChanged;
  final bool enabled;
  final int maxImages;

  @override
  State<GalleryPicker> createState() =>
      _GalleryPickerState();
}

class _GalleryPickerState
    extends State<GalleryPicker> {
final ImagePicker _picker = ImagePicker();

late List<File> _images;

bool _loading = false;

@override
void initState() {
super.initState();

_images = List<File>.from(
widget.initialImages,
);
}

Future<void> _pickGallery() async {
if (!widget.enabled || _loading) {
return;
}

try {
setState(() {
_loading = true;
});

final picked =
await _picker.pickMultiImage(
imageQuality: 85,
maxWidth: 1600,
);

if (picked.isEmpty) {
return;
}

for (final image in picked) {
if (_images.length >=
widget.maxImages) {
break;
}

_images.add(
File(image.path),
);
}

if (!mounted) {
return;
}

setState(() {});

widget.onChanged(_images);
} finally {
if (mounted) {
setState(() {
_loading = false;
});
}
}
}

Future<void> _pickCamera() async {
if (!widget.enabled || _loading) {
return;
}

if (_images.length >=
widget.maxImages) {
return;
}

final picked =
await _picker.pickImage(
source: ImageSource.camera,
imageQuality: 85,
maxWidth: 1600,
);

if (picked == null) {
return;
}

setState(() {
_images.add(
File(picked.path),
);
});

widget.onChanged(_images);
}

void _removeImage(
int index,
) {
setState(() {
_images.removeAt(index);
});

widget.onChanged(_images);
}

Future<void> _showPicker() async {
await showModalBottomSheet<void>(
context: context,
builder: (_) {
return SafeArea(
child: Wrap(
children: [
ListTile(
leading: const Icon(
Icons.photo_library_outlined,
),
title: const Text(
'Choose from Gallery',
),
onTap: () {
Navigator.pop(context);
_pickGallery();
},
),
ListTile(
leading: const Icon(
Icons.camera_alt_outlined,
),
title: const Text(
'Take Photo',
),
onTap: () {
Navigator.pop(context);
_pickCamera();
},
),
],
),
);
},
);
}

@override
Widget build(
BuildContext context,
) {
return Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
'Gallery Images',
style: Theme.of(context)
.textTheme
.titleMedium,
),
const SizedBox(height: 12),
GridView.builder(
shrinkWrap: true,
physics:
const NeverScrollableScrollPhysics(),
gridDelegate:
const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 3,
crossAxisSpacing: 12,
mainAxisSpacing: 12,
childAspectRatio: 1,
),
itemCount:
_images.length <
widget.maxImages
? _images.length + 1
: _images.length,
itemBuilder:
(context, index) {
  if (index == _images.length) {
    return InkWell(
      onTap: widget.enabled
          ? _showPicker
          : null,
      borderRadius:
      BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context)
                .dividerColor,
          ),
        ),
        child: Icon(
          Icons.add_photo_alternate_outlined,
          size: 40,
          color: Theme.of(context)
              .colorScheme
              .primary,
        ),
      ),
    );
  }

  final image = _images[index];

  return Stack(
    fit: StackFit.expand,
    children: [
      ClipRRect(
        borderRadius:
        BorderRadius.circular(16),
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
      if (widget.enabled)
        Positioned(
          top: 6,
          right: 6,
          child: Material(
            color: Colors.red,
            shape:
            const CircleBorder(),
            child: InkWell(
              customBorder:
              const CircleBorder(),
              onTap: () =>
                  _removeImage(index),
              child: const Padding(
                padding:
                EdgeInsets.all(6),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
    ],
  );
},
),

  const SizedBox(height: 12),

  Row(
    children: [
      Text(
        '${_images.length} / ${widget.maxImages} Images',
        style: Theme.of(context)
            .textTheme
            .bodySmall,
      ),

      const Spacer(),

      if (_loading)
        const SizedBox(
          width: 20,
          height: 20,
          child:
          CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
    ],
  ),
],
);
}
}
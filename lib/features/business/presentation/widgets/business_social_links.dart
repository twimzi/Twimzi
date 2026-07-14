import 'package:flutter/material.dart';

class BusinessSocialLinks extends StatelessWidget {
  const BusinessSocialLinks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.facebook, size: 32),
            Icon(Icons.camera_alt, size: 32),
            Icon(Icons.play_circle, size: 32),
            Icon(Icons.business, size: 32),
            Icon(Icons.public, size: 32),
          ],
        ),
      ),
    );
  }
}
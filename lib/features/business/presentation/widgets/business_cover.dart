import 'package:flutter/material.dart';

class BusinessCover extends StatelessWidget {
  final String imageUrl;

  const BusinessCover({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      child: imageUrl.isEmpty
          ? const Center(
        child: Icon(
          Icons.store,
          size: 80,
        ),
      )
          : Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
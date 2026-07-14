import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({
    super.key,
    required this.name,
    required this.category,
    required this.location,
  });

  final String name;
  final String category;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.store),
        ),
        title: Text(name),
        subtitle: Text('$category • $location'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Businesses'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 15,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 28,
                child: Icon(Icons.store),
              ),
              title: Text('Business ${index + 1}'),
              subtitle: Text('Category • ${index + 1}.0 km'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to Business Detail Page
              },
            ),
          );
        },
      ),
    );
  }
}
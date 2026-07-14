import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search businesses, products, services...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.store),
                    ),
                    title: Text('ABC Electronics'),
                    subtitle: Text('Electronics • Ludhiana'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.restaurant),
                    ),
                    title: Text('Punjab Fast Food'),
                    subtitle: Text('Restaurant • Ludhiana'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.local_hospital),
                    ),
                    title: Text('City Hospital'),
                    subtitle: Text('Hospital • Ludhiana'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
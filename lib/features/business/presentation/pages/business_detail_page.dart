import 'package:flutter/material.dart';

class BusinessDetailPage extends StatelessWidget {
  const BusinessDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('ABC Electronics'),
              background: Container(
                color: Colors.blueGrey.shade300,
                child: const Center(
                  child: Icon(
                    Icons.store,
                    size: 90,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Electronics Store',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Model Town, Ludhiana',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 6),
                      Text('4.8'),
                      SizedBox(width: 12),
                      Text('(245 Reviews)'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'ABC Electronics is one of the leading electronics retailers in Ludhiana offering TVs, ACs, Refrigerators, Washing Machines and more.',
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.call),
                          label: const Text('Call'),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.chat),
                          label: const Text('Chat'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.map),
                      label: const Text('Directions'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
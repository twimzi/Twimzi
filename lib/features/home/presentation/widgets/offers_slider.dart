import 'package:flutter/material.dart';

class OffersSlider extends StatelessWidget {
  const OffersSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: PageView(
        children: [
          _offer('50% OFF', 'Punjab Electronics'),
          _offer('Buy 1 Get 1', 'Pizza Hub'),
          _offer('Flat ₹500 OFF', 'City Gym'),
        ],
      ),
    );
  }

  Widget _offer(String title, String subtitle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
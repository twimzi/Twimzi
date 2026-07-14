import 'package:flutter/material.dart';

class BusinessGallery extends StatelessWidget {
  const BusinessGallery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gallery',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (_, index) {
                  return Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
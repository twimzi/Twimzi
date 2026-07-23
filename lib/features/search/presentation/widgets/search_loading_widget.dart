import 'package:flutter/material.dart';

/// Loading widget displayed while search results are being fetched.
class SearchLoadingWidget extends StatelessWidget {
  const SearchLoadingWidget({super.key});

  static const int _itemCount = 8;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: _itemCount,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, _) => const _LoadingTile(),
    );
  }
}

class _LoadingTile extends StatelessWidget {
  const _LoadingTile();

  @override
  Widget build(BuildContext context) {
    final color =
        Theme.of(context).colorScheme.surfaceContainerHighest;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LoadingLine(
                    width: 180,
                    height: 18,
                    color: color,
                  ),
                  const SizedBox(height: 10),
                  _LoadingLine(
                    width: 120,
                    height: 14,
                    color: color,
                  ),
                  const SizedBox(height: 12),
                  _LoadingLine(
                    width: double.infinity,
                    height: 12,
                    color: color,
                  ),
                  const SizedBox(height: 6),
                  _LoadingLine(
                    width: 220,
                    height: 12,
                    color: color,
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      3,
                          (_) => Container(
                        width: 70,
                        height: 28,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                      ),
                    ),
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

class _LoadingLine extends StatelessWidget {
  const _LoadingLine({
    required this.width,
    required this.height,
    required this.color,
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
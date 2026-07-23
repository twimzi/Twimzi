import 'package:flutter/material.dart';

class SearchEmptyWidget extends StatelessWidget {
  const SearchEmptyWidget({
    super.key,
    this.query,
    this.onRetry,
  });

  final String? query;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchQuery = query?.trim() ?? '';
    final hasQuery = searchQuery.isNotEmpty;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 56,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              hasQuery ? 'No Results Found' : 'Start Searching',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              hasQuery
                  ? 'No businesses, products or services matched "$searchQuery". Try another keyword.'
                  : 'Search businesses, products, services and categories across Twimzi.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: onRetry ??
                      () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
              icon: const Icon(Icons.search),
              label: Text(
                hasQuery ? 'Search Again' : 'Start Search',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
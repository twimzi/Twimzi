import 'package:flutter/material.dart';

import '../../domain/entities/search_result.dart';

class BusinessResultTile extends StatelessWidget {
  const BusinessResultTile({
    super.key,
    required this.result,
    required this.onTap,
  });

  final SearchResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BusinessThumbnail(
                imageUrl: result.thumbnail,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            result.title,
                            maxLines: 1,
                            overflow:
                            TextOverflow.ellipsis,
                            style: theme
                                .textTheme.titleMedium
                                ?.copyWith(
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                        if (result.featured)
                          Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade100,
                              borderRadius:
                              BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: Text(
                              'Featured',
                              style: theme
                                  .textTheme.labelSmall
                                  ?.copyWith(
                                color: Colors.orange,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    if ((result.subtitle ?? '')
                        .isNotEmpty)
                      Text(
                        result.subtitle!,
                        maxLines: 2,
                        overflow:
                        TextOverflow.ellipsis,
                        style:
                        theme.textTheme.bodyMedium,
                      ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          result.rating
                              .toStringAsFixed(1),
                          style: theme
                              .textTheme.bodySmall,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BusinessThumbnail extends StatelessWidget {
  const _BusinessThumbnail({
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null ||
        imageUrl!.trim().isEmpty) {
      return Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest,
          borderRadius:
          BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.storefront_rounded,
          size: 34,
        ),
      );
    }

    return ClipRRect(
      borderRadius:
      BorderRadius.circular(12),
      child: Image.network(
        imageUrl!,
        width: 72,
        height: 72,
        fit: BoxFit.cover,
        errorBuilder:
            (_, _, _) => Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest,
            borderRadius:
            BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.storefront_rounded,
            size: 34,
          ),
        ),
      ),
    );
  }
}
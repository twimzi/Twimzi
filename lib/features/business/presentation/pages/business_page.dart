import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/business_provider.dart';

class BusinessPage extends ConsumerWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businesses = ref.watch(myBusinessesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Businesses'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to Create Business Page
        },
        icon: const Icon(Icons.add_business),
        label: const Text('Add Business'),
      ),
      body: businesses.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              error.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.storefront_outlined,
                      size: 72,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No Businesses Yet',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Create your first business to start selling on Twimzi.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () {
                        // TODO: Navigate to Create Business
                      },
                      icon: const Icon(Icons.add_business),
                      label: const Text(
                        'Create Business',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(myBusinessesProvider);
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, _) =>
              const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final business = items[index];

                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 26,
                      child: Text(
                        business.businessName
                            .substring(0, 1)
                            .toUpperCase(),
                      ),
                    ),
                    title: Text(
                      business.businessName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          business.businessType,
                        ),
                        if ((business.handle ?? '')
                            .isNotEmpty)
                          Text(
                            '@${business.handle}',
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                    onTap: () {
                      // TODO: Business Details
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
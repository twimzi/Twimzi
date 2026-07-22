import 'package:flutter/material.dart';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to Add Service
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Service'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Refresh services
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                8,
              ),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search services...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // TODO: Filter
                      },
                      icon: const Icon(Icons.filter_list),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return _ServiceCard(
                      serviceName: 'Service ${index + 1}',
                      category: 'General',
                      price: '₹499',
                      duration: '30 min',
                      active: true,
                      featured: index.isEven,
                      onTap: () {
                        // TODO: Open Details
                      },
                    );
                  },
                  childCount: 12,
                ),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: .82,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.serviceName,
    required this.category,
    required this.price,
    required this.duration,
    required this.active,
    required this.featured,
    required this.onTap,
  });

  final String serviceName;
  final String category;
  final String price;
  final String duration;
  final bool active;
  final bool featured;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.design_services,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                serviceName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium,
              ),

              const SizedBox(height: 4),

              Text(
                category,
                style: theme.textTheme.bodySmall,
              ),

              const Spacer(),

              Text(
                price,
                style: theme.textTheme.titleMedium
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      duration,
                      style:
                      theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Chip(
                    label: Text(
                      active
                          ? 'Active'
                          : 'Draft',
                    ),
                  ),
                  const Spacer(),
                  if (featured)
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
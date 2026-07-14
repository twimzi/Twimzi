import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/business_provider.dart';

class BusinessProfilePage extends ConsumerWidget {
  final String businessId;

  const BusinessProfilePage({
    super.key,
    required this.businessId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessAsync = ref.watch(
      businessProvider(businessId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Profile'),
      ),
      body: businessAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        data: (business) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const CircleAvatar(
                radius: 45,
                child: Icon(
                  Icons.store,
                  size: 40,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                business.businessName,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall,
              ),

              const SizedBox(height: 8),

              Text(
                business.businessType,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.badge),
                  title: const Text('Business Code'),
                  subtitle: Text(
                    business.businessCode,
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Description'),
                  subtitle: Text(
                    business.description ?? '-',
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(
                    business.email ?? '-',
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone'),
                  subtitle: Text(
                    business.phone ?? '-',
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Website'),
                  subtitle: Text(
                    business.website ?? '-',
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.verified),
                  title: const Text('Verification'),
                  subtitle: Text(
                    business.verificationStatus,
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Business Status'),
                  subtitle: Text(
                    business.businessStatus,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}
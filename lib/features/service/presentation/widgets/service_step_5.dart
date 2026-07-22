import 'package:flutter/material.dart';

class ServiceStep5 extends StatelessWidget {
  const ServiceStep5({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review Service',
            style: theme.textTheme.headlineSmall,
          ),

          const SizedBox(height: 8),

          Text(
            'Please review all information before creating the service.',
            style: theme.textTheme.bodyMedium,
          ),

          const SizedBox(height: 24),

          _SectionCard(
            title: 'Service Information',
            icon: Icons.design_services,
            children: const [
              _InfoRow(
                label: 'Service Name',
                value: 'Cleaning Service',
              ),
              _InfoRow(
                label: 'Category',
                value: 'Cleaning',
              ),
              _InfoRow(
                label: 'Description',
                value: 'Professional cleaning service.',
              ),
            ],
          ),

          const SizedBox(height: 16),

          _SectionCard(
            title: 'Pricing',
            icon: Icons.payments,
            children: const [
              _InfoRow(
                label: 'Price',
                value: '₹499',
              ),
              _InfoRow(
                label: 'Pricing Type',
                value: 'Fixed',
              ),
              _InfoRow(
                label: 'Duration',
                value: '30 Minutes',
              ),
            ],
          ),

          const SizedBox(height: 16),

          _SectionCard(
            title: 'Availability',
            icon: Icons.schedule,
            children: const [
              _InfoRow(
                label: 'Working Days',
                value: 'Mon - Sat',
              ),
              _InfoRow(
                label: 'Working Hours',
                value: '09:00 AM - 06:00 PM',
              ),
              _InfoRow(
                label: 'Appointment',
                value: 'Required',
              ),
            ],
          ),

          const SizedBox(height: 16),

          _SectionCard(
            title: 'Status',
            icon: Icons.verified,
            children: const [
              _InfoRow(
                label: 'Active',
                value: 'Yes',
              ),
              _InfoRow(
                label: 'Featured',
                value: 'No',
              ),
              _InfoRow(
                label: 'Home Service',
                value: 'Available',
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'After tapping Create Service, your service information and images will be uploaded to Supabase and Cloudflare R2.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                // TODO:
                // Create Service
              },
              icon: const Icon(Icons.check_circle),
              label: const Text(
                'Create Service',
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium,
                ),
              ],
            ),

            const SizedBox(height: 16),

            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class BusinessActionButtons extends StatelessWidget {
  const BusinessActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.call),
            label: const Text('Call'),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.chat),
            label: const Text('Chat'),
          ),
        ),
      ],
    );
  }
}
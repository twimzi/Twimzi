import 'package:flutter/material.dart';

class DeleteProductDialog extends StatelessWidget {
  const DeleteProductDialog({
    super.key,
    required this.productName,
    required this.onConfirm,
  });

  final String productName;
  final Future<void> Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.delete_forever_rounded,
        color: Colors.red,
        size: 36,
      ),
      title: const Text(
        'Delete Product',
      ),
      content: Text(
        'Are you sure you want to delete "$productName"?\n\n'
            'This action cannot be undone.',
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
          ),
        ),
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          icon: const Icon(
            Icons.delete_outline,
          ),
          label: const Text(
            'Delete',
          ),
          onPressed: () async {
            Navigator.pop(context);
            await onConfirm();
          },
        ),
      ],
    );
  }

  static Future<bool> show(
      BuildContext context, {
        required String productName,
        required Future<void> Function() onConfirm,
      }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => DeleteProductDialog(
        productName: productName,
        onConfirm: () async {
          await onConfirm();
        },
      ),
    );

    return result ?? false;
  }
}
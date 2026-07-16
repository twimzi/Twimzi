import 'package:flutter/material.dart';

class DeleteProductDialog extends StatelessWidget {
  const DeleteProductDialog({
    super.key,
    required this.productName,
    required this.onDelete,
    this.isLoading = false,
  });

  final String productName;
  final VoidCallback onDelete;
  final bool isLoading;

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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Are you sure you want to delete this product?',
          ),
          const SizedBox(height: 12),
          Text(
            productName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          const Text(
            'This action cannot be undone.',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading
              ? null
              : () => Navigator.pop(context),
          child: const Text(
            'Cancel',
          ),
        ),
        FilledButton.icon(
          onPressed: isLoading ? null : onDelete,
          icon: isLoading
              ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : const Icon(Icons.delete),
          label: Text(
            isLoading
                ? 'Deleting...'
                : 'Delete',
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }
}
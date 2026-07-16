
import 'package:flutter/material.dart';

class ProductSubmitButton extends StatelessWidget {
  const ProductSubmitButton({
    super.key,
    required this.isLoading,
    required this.onSubmit,
    this.label = 'Save Product',
  });

  final bool isLoading;
  final VoidCallback? onSubmit;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        onPressed: isLoading ? null : onSubmit,
        icon: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )
            : const Icon(Icons.save_outlined),
        label: Text(label),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/product_search_provider.dart';

class ProductSearchBar extends ConsumerWidget {
  const ProductSearchBar({
    super.key,
    this.hintText = 'Search products...',
    this.autofocus = false,
  });

  final String hintText;
  final bool autofocus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(
      productSearchQueryProvider,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        autofocus: autofocus,
        controller: TextEditingController(
          text: query,
        )..selection = TextSelection.fromPosition(
          TextPosition(
            offset: query.length,
          ),
        ),
        onChanged: (value) {
          ref
              .read(
            productSearchQueryProvider.notifier,
          )
              .state = value;
        },
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(
            Icons.search,
          ),
          suffixIcon: query.isEmpty
              ? null
              : IconButton(
            icon: const Icon(
              Icons.clear,
            ),
            onPressed: () {
              ref
                  .read(
                productSearchQueryProvider
                    .notifier,
              )
                  .state = '';
            },
          ),
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
          ),
          filled: true,
        ),
      ),
    );
  }
}
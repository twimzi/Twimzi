import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import 'add_product_page.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return AddProductPage(
      businessId: product.businessId,
      product: product,
      isEdit: true,
    );
  }
}
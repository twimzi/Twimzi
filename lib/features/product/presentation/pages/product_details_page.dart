import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../widgets/add_product/delete_product_dialog.dart';
import 'edit_product_page.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  ConsumerState<ProductDetailsPage> createState() =>
      _ProductDetailsPageState();
}

class _ProductDetailsPageState
    extends ConsumerState<ProductDetailsPage> {
bool _isDeleting = false;

Future<void> _deleteProduct({
required String productId,
required String productName,
}) async {
final confirmed = await showDialog<bool>(
context: context,
builder: (_) => DeleteProductDialog(
productName: productName,
isLoading: _isDeleting,
onDelete: () {
Navigator.of(context).pop(true);
},
),
);

if (confirmed != true) return;

setState(() {
_isDeleting = true;
});

try {
await ref
.read(productRepositoryProvider)
.deleteProduct(productId);

ref.invalidate(productsProvider);

if (!mounted) return;

Navigator.of(context).pop();

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Product deleted successfully',
),
),
);
} catch (e) {
if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
e.toString(),
),
),
);
} finally {
if (mounted) {
setState(() {
_isDeleting = false;
});
}
}
}

@override
Widget build(BuildContext context) {
final productAsync =
ref.watch(productProvider(widget.productId));
return Scaffold(
appBar: AppBar(
title: const Text('Product Details'),
actions: [
productAsync.when(
loading: () => const SizedBox.shrink(),
  error: (error, stackTrace) => const SizedBox.shrink(),
data: (product) {
return PopupMenuButton<String>(
onSelected: (value) async {
switch (value) {
case 'edit':
await Navigator.of(context).push(
MaterialPageRoute(
  builder: (context) => EditProductPage(
productId: product.id,
businessId: product.businessId,
),
),
);

if (mounted) {
ref.invalidate(
productProvider(widget.productId),
);
ref.invalidate(productsProvider);
}
break;

case 'delete':
await _deleteProduct(
productId: product.id,
productName: product.productName,
);
break;
}
},
itemBuilder: (_) => const [
PopupMenuItem(
value: 'edit',
child: ListTile(
leading: Icon(Icons.edit_outlined),
title: Text('Edit Product'),
contentPadding: EdgeInsets.zero,
),
),
PopupMenuItem(
value: 'delete',
child: ListTile(
leading: Icon(Icons.delete_outline),
title: Text('Delete Product'),
contentPadding: EdgeInsets.zero,
),
),
],
);
},
),
],
),
body: productAsync.when(
loading: () => const Center(
child: CircularProgressIndicator(),
),
error: (error, _) => Center(
child: Padding(
padding: const EdgeInsets.all(24),
child: Text(
error.toString(),
textAlign: TextAlign.center,
),
),
),
data: (product) {
return ListView(
padding: const EdgeInsets.all(16),
children: [
Card(
elevation: 0,
clipBehavior: Clip.antiAlias,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(20),
),
child: product.thumbnailUrl != null &&
product.thumbnailUrl!.isNotEmpty
? Image.network(
product.thumbnailUrl!,
height: 240,
width: double.infinity,
fit: BoxFit.cover,
)
: SizedBox(
height: 220,
child: Center(
child: Icon(
Icons.image_outlined,
size: 80,
color: Colors.grey.shade400,
),
),
),
),
const SizedBox(height: 24),
Text(
product.productName,
style:
Theme.of(context).textTheme.headlineSmall,
),
  const SizedBox(height: 8),

  if (product.brand != null &&
      product.brand!.isNotEmpty)
    Text(
      product.brand!,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(
        color: Colors.grey.shade600,
      ),
    ),

  const SizedBox(height: 24),
Card(
elevation: 0,
child: Padding(
padding: const EdgeInsets.all(16),
child: Column(
children: [
ListTile(
dense: true,
leading: const Icon(Icons.qr_code),
title: const Text('Product Code'),
trailing: Text(product.productCode),
),
ListTile(
dense: true,
leading: const Icon(Icons.confirmation_number),
title: const Text('SKU'),
trailing: Text(product.sku),
),
if (product.brand != null &&
product.brand!.isNotEmpty)
ListTile(
dense: true,
leading: const Icon(Icons.branding_watermark),
title: const Text('Brand'),
trailing: Text(product.brand!),
),
if (product.model != null &&
product.model!.isNotEmpty)
ListTile(
dense: true,
leading: const Icon(Icons.precision_manufacturing),
title: const Text('Model'),
trailing: Text(product.model!),
),
],
),
),
),
const SizedBox(height: 20),
  Card(
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.sell_outlined),
            title: const Text('Selling Price'),
            trailing: Text(
              '₹ ${product.sellingPrice}',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.price_change_outlined),
            title: const Text('MRP'),
            trailing: Text(
              '₹ ${product.mrp}',
            ),
          ),
        ],
      ),
    ),
  ),
  const SizedBox(height: 20),
  Card(
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Available Stock'),
            trailing: Chip(
              label: Text(
                '${product.stockQuantity}',
              ),
            ),
          ),
        ],
      ),
    ),
  ),
  if (product.description.isNotEmpty) ...[
    const SizedBox(height: 20),
    Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              product.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
          ],
        ),
      ),
    ),
  ],
  const SizedBox(height: 40),
],
);
},
),
);
}
}

import 'package:flutter/material.dart';

import '../../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
const ProductCard({
super.key,
required this.product,
this.onTap,
this.onEdit,
this.onDelete,
});

final ProductModel product;

final VoidCallback? onTap;
final VoidCallback? onEdit;
final VoidCallback? onDelete;

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

return Card(
margin: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 8,
),
elevation: 3,
clipBehavior: Clip.antiAlias,
shadowColor: Colors.black12,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),
child: InkWell(
onTap: onTap,
borderRadius: BorderRadius.circular(18),
child: Padding(
padding: const EdgeInsets.all(16),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Hero(
tag: 'product_${product.id}',
child: ClipRRect(
borderRadius: BorderRadius.circular(14),
child: Container(
width: 88,
height: 88,
color: theme.colorScheme.surfaceContainerHighest,
child: product.thumbnailUrl != null &&
product.thumbnailUrl!.isNotEmpty
? Image.network(
product.thumbnailUrl!,
fit: BoxFit.cover,
errorBuilder:
    (_, error, stackTrace) => Icon(
Icons.inventory_2_outlined,
size: 36,
color: theme.colorScheme.primary,
),
)
: Icon(
Icons.inventory_2_outlined,
size: 36,
color: theme.colorScheme.primary,
),
),
),
),
const SizedBox(width: 16),
Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Row(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Expanded(
child: Text(
product.productName,
maxLines: 2,
overflow:
TextOverflow.ellipsis,
style: theme
.textTheme
.titleMedium
?.copyWith(
fontWeight:
FontWeight.w700,
letterSpacing: -.2,
),
),
),
const SizedBox(width: 8),
Chip(
avatar: Icon(
product.isActive
? Icons.check_circle
: Icons.cancel,
size: 16,
color: product.isActive
? Colors.green
: Colors.red,
),
label: Text(
product.isActive
? 'Active'
: 'Inactive',
),
),
],
),
const SizedBox(height: 6),
Text(
product.productCode,
style: theme.textTheme.bodySmall
?.copyWith(
color: Colors.grey.shade600,
),
),
if (product.brand != null &&
product.brand!.isNotEmpty) ...[
const SizedBox(height: 4),
Text(
product.brand!,
style: theme
.textTheme
.bodySmall
?.copyWith(
fontWeight:
FontWeight.w600,
color:
Colors.grey.shade700,
),
),
],
const SizedBox(height: 14),
Row(
children: [
Text(
'₹${product.sellingPrice.toStringAsFixed(0)}',
style: theme
.textTheme
.titleLarge
?.copyWith(
color: theme
.colorScheme
.primary,
fontWeight:
FontWeight.bold,
),
),
const SizedBox(width: 8),
if (product.mrp >
product.sellingPrice)
Text(
'₹${product.mrp.toStringAsFixed(0)}',
style: theme
.textTheme
.bodySmall
?.copyWith(
decoration:
TextDecoration
.lineThrough,
color: Colors.grey,
),
),
],
),
const SizedBox(height: 14),
Wrap(
spacing: 8,
runSpacing: 8,
children: [
Chip(
avatar: Icon(
product.stockQuantity > 0
? Icons.inventory
: Icons.warning_amber,
size: 16,
),
label: Text(
product.stockQuantity > 0
? 'In Stock (${product.stockQuantity})'
: 'Out of Stock',
),
),
if (product.isFeatured)
const Chip(
avatar: Icon(
Icons.star,
size: 16,
),
label: Text('Featured'),
),
],
),
],
),
),
  PopupMenuButton<String>(
    tooltip: 'More',
    onSelected: (value) {
      switch (value) {
        case 'edit':
          onEdit?.call();
          break;

        case 'delete':
          onDelete?.call();
          break;
      }
    },
    itemBuilder: (_) => const [
      PopupMenuItem<String>(
        value: 'edit',
        child: ListTile(
          leading: Icon(Icons.edit_outlined),
          title: Text('Edit Product'),
          contentPadding: EdgeInsets.zero,
        ),
      ),
      PopupMenuItem<String>(
        value: 'delete',
        child: ListTile(
          leading: Icon(Icons.delete_outline),
          title: Text('Delete Product'),
          contentPadding: EdgeInsets.zero,
        ),
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

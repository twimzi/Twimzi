import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/storage_repository.dart';
import '../../domain/models/create_product_request.dart';
import '../models/product_model.dart';

class ProductRepository {
  final SupabaseClient _client;
  final StorageRepository _storageRepository;

  ProductRepository({
    SupabaseClient? client,
    required this._storageRepository,
  }) : _client = client ?? Supabase.instance.client;

Future<List<ProductModel>> getProducts() async {
final response = await _client
.from('products')
.select()
.isFilter(
'deleted_at',
null,
)
.order(
'product_name',
ascending: true,
);

return (response as List)
.map(
(json) => ProductModel.fromJson(
json as Map<String, dynamic>,
),
)
.toList();
}

Future<List<ProductModel>> getBusinessProducts(
String businessId,
) async {
final response = await _client
.from('products')
.select()
.eq(
'business_id',
businessId,
)
.isFilter(
'deleted_at',
null,
)
.order(
'product_name',
ascending: true,
);

return (response as List)
.map(
(json) => ProductModel.fromJson(
json as Map<String, dynamic>,
),
)
.toList();
}

Future<ProductModel> getProduct(
String id,
) async {
final response = await _client
.from('products')
.select()
.eq(
'id',
id,
)
.single();

return ProductModel.fromJson(
response,
);
}

Future<String> createProduct(
CreateProductRequest request,
) async {
final slug = request.productName
.trim()
.toLowerCase()
.replaceAll(
RegExp(r'[^a-z0-9]+'),
'-',
)
.replaceAll(
RegExp(r'-+'),
'-',
)
.replaceAll(
RegExp(r'^-|-$'),
'',
);

final inserted = await _client
.from('products')
.insert({
'business_id': request.businessId,
'category_id': request.categoryId,
'product_code': request.productCode,
'sku': request.sku,
'barcode': request.barcode,
'product_name': request.productName,
'slug': slug,
'short_description':
request.shortDescription,
'description': request.description,
'brand': request.brand,
'model': request.model,
'unit_id': request.unitId,
'currency_id': request.currencyId,
'selling_price': request.sellingPrice,
'mrp': request.mrp,
'cost_price': request.costPrice,
'stock_quantity':
request.stockQuantity,
'minimum_stock':
request.minimumStock,
'maximum_stock':
request.maximumStock,
'weight': request.weight,
'length': request.length,
'width': request.width,
'height': request.height,
'is_featured':
request.isFeatured,
'is_active':
request.isActive,
})
.select('id')
.single();

final productId =
inserted['id'] as String;

final folder =
_storageRepository.getProductFolder(
businessId: request.businessId,
productId: productId,
);

String? thumbnailUrl;
final List<String> galleryUrls = [];
if (request.hasThumbnail) {
thumbnailUrl =
await _storageRepository.uploadImage(
file: request.thumbnail!,
folder: folder,
fileName: 'thumbnail',
);
}

if (request.hasGalleryImages) {
galleryUrls.addAll(
await _storageRepository.uploadImages(
files: request.galleryImages,
folder: '$folder/gallery',
),
);
}

await _client
.from('products')
.update({
'thumbnail_url': thumbnailUrl,
'gallery_images': galleryUrls,
'image_count': request.totalImages,
})
.eq(
'id',
productId,
);

return productId;
}

Future<void> updateProductData(
ProductModel product,
) async {
await _client
.from('products')
.update(
product.toJson(),
)
.eq(
'id',
product.id,
);
}

Future<void> updateProductImages({
required ProductModel product,
required CreateProductRequest request,
}) async {
final folder =
_storageRepository.getProductFolder(
businessId: product.businessId,
productId: product.id,
);

String? thumbnailUrl =
product.thumbnailUrl;

final List<String> galleryUrls =
List<String>.from(
product.galleryImages,
);

if (request.hasThumbnail) {
thumbnailUrl =
await _storageRepository.replaceImage(
newFile: request.thumbnail!,
oldImageUrl: product.thumbnailUrl,
folder: folder,
fileName: 'thumbnail',
);
}

if (request.hasGalleryImages) {
if (product.galleryImages.isNotEmpty) {
await _storageRepository.deleteImages(
imageUrls: product.galleryImages,
);
}

galleryUrls
..clear()
..addAll(
await _storageRepository.uploadImages(
files: request.galleryImages,
folder: '$folder/gallery',
),
);
}

await _client
.from('products')
.update({
'thumbnail_url': thumbnailUrl,
'gallery_images': galleryUrls,
'image_count':
galleryUrls.length +
(thumbnailUrl == null ? 0 : 1),
})
.eq(
'id',
product.id,
);
}
Future<void> deleteProduct(
String id,
) async {
final product = await getProduct(id);

await _storageRepository.deleteFolder(
folder: _storageRepository.getProductFolder(
businessId: product.businessId,
productId: product.id,
),
);

await _client
.from('products')
.update({
'deleted_at':
DateTime.now().toIso8601String(),
'thumbnail_url': null,
'gallery_images': <String>[],
'image_count': 0,
'is_active': false,
})
.eq(
'id',
id,
);
}

Future<bool> productExists(
String id,
) async {
final response = await _client
.from('products')
.select('id')
.eq(
'id',
id,
)
.maybeSingle();

return response != null;
}

Future<int> totalProducts() async {
final response = await _client
.from('products')
.select('id')
.isFilter(
'deleted_at',
null,
);

return (response as List).length;
}

Stream<List<ProductModel>> watchProducts() {
return _client
.from('products')
.stream(
primaryKey: const ['id'],
)
.order(
'product_name',
)
.map(
(rows) => rows
.where(
(row) =>
row['deleted_at'] == null,
)
.map(
(row) => ProductModel.fromJson(
row,
),
)
.toList(),
);
}

Stream<List<ProductModel>>
watchBusinessProducts(
String businessId,
) {
return _client
.from('products')
.stream(
primaryKey: const ['id'],
)
.eq(
'business_id',
businessId,
)
.order(
'product_name',
)
.map(
(rows) => rows
.where(
(row) =>
row['deleted_at'] == null,
)
.map(
(row) => ProductModel.fromJson(
row,
),
)
.toList(),
);
}
}

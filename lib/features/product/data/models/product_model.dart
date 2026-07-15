class ProductModel {
final String id;

final String businessId;
final String? categoryId;

final String productCode;
final String sku;
final String? barcode;

final String productName;
final String slug;

final String shortDescription;
final String description;

final String? brand;
final String? model;

final String? unitId;
final String? currencyId;

final double sellingPrice;
final double mrp;
final double costPrice;

final int stockQuantity;
final int minimumStock;
final int maximumStock;

final double weight;
final double length;
final double width;
final double height;

/// Images
final String? thumbnailUrl;
final List<String> galleryImages;
final int imageCount;

/// Status
final bool isFeatured;
final bool isActive;

/// Audit
final DateTime createdAt;
final DateTime updatedAt;

final String? createdBy;
final String? updatedBy;

final DateTime? deletedAt;

const ProductModel({
required this.id,
required this.businessId,
this.categoryId,
required this.productCode,
required this.sku,
this.barcode,
required this.productName,
required this.slug,
required this.shortDescription,
required this.description,
this.brand,
this.model,
this.unitId,
this.currencyId,
required this.sellingPrice,
required this.mrp,
required this.costPrice,
required this.stockQuantity,
required this.minimumStock,
required this.maximumStock,
required this.weight,
required this.length,
required this.width,
required this.height,
this.thumbnailUrl,
this.galleryImages = const [],
this.imageCount = 0,
required this.isFeatured,
required this.isActive,
required this.createdAt,
required this.updatedAt,
this.createdBy,
this.updatedBy,
this.deletedAt,
});

factory ProductModel.fromJson(
Map<String, dynamic> json,
) {
return ProductModel(
id: json['id'] as String,
businessId: json['business_id'] as String,
categoryId: json['category_id'] as String?,
productCode: json['product_code'] as String,
sku: json['sku'] as String,
barcode: json['barcode'] as String?,
productName: json['product_name'] as String,
slug: json['slug'] as String,
shortDescription:
(json['short_description'] ?? '') as String,
description:
(json['description'] ?? '') as String,
brand: json['brand'] as String?,
model: json['model'] as String?,
unitId: json['unit_id'] as String?,
currencyId: json['currency_id'] as String?,
sellingPrice:
(json['selling_price'] ?? 0).toDouble(),
mrp:
(json['mrp'] ?? 0).toDouble(),
costPrice:
(json['cost_price'] ?? 0).toDouble(),
stockQuantity:
json['stock_quantity'] ?? 0,
minimumStock:
json['minimum_stock'] ?? 0,
maximumStock:
json['maximum_stock'] ?? 0,
weight:
(json['weight'] ?? 0).toDouble(),
length:
(json['length'] ?? 0).toDouble(),
width:
(json['width'] ?? 0).toDouble(),
height:
(json['height'] ?? 0).toDouble(),
thumbnailUrl:
json['thumbnail_url'] as String?,
galleryImages:
json['gallery_images'] == null
? const []
: List<String>.from(
json['gallery_images'] as List,
),
imageCount:
json['image_count'] ?? 0,
isFeatured:
json['is_featured'] ?? false,
isActive:
json['is_active'] ?? true,
createdAt: DateTime.parse(
json['created_at'],
),
updatedAt: DateTime.parse(
json['updated_at'],
),
createdBy:
json['created_by'] as String?,
updatedBy:
json['updated_by'] as String?,
deletedAt: json['deleted_at'] == null
? null
: DateTime.parse(
json['deleted_at'],
),
);
}
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'business_id': businessId,
    'category_id': categoryId,
    'product_code': productCode,
    'sku': sku,
    'barcode': barcode,
    'product_name': productName,
    'slug': slug,
    'short_description': shortDescription,
    'description': description,
    'brand': brand,
    'model': model,
    'unit_id': unitId,
    'currency_id': currencyId,
    'selling_price': sellingPrice,
    'mrp': mrp,
    'cost_price': costPrice,
    'stock_quantity': stockQuantity,
    'minimum_stock': minimumStock,
    'maximum_stock': maximumStock,
    'weight': weight,
    'length': length,
    'width': width,
    'height': height,
    'thumbnail_url': thumbnailUrl,
    'gallery_images': galleryImages,
    'image_count': imageCount,
    'is_featured': isFeatured,
    'is_active': isActive,
  };
}

ProductModel copyWith({
  String? id,
  String? businessId,
  String? categoryId,
  String? productCode,
  String? sku,
  String? barcode,
  String? productName,
  String? slug,
  String? shortDescription,
  String? description,
  String? brand,
  String? model,
  String? unitId,
  String? currencyId,
  double? sellingPrice,
  double? mrp,
  double? costPrice,
  int? stockQuantity,
  int? minimumStock,
  int? maximumStock,
  double? weight,
  double? length,
  double? width,
  double? height,
  String? thumbnailUrl,
  List<String>? galleryImages,
  int? imageCount,
  bool? isFeatured,
  bool? isActive,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? createdBy,
  String? updatedBy,
  DateTime? deletedAt,
}) {
  return ProductModel(
    id: id ?? this.id,
    businessId: businessId ?? this.businessId,
    categoryId: categoryId ?? this.categoryId,
    productCode: productCode ?? this.productCode,
    sku: sku ?? this.sku,
    barcode: barcode ?? this.barcode,
    productName: productName ?? this.productName,
    slug: slug ?? this.slug,
    shortDescription:
    shortDescription ?? this.shortDescription,
    description:
    description ?? this.description,
    brand: brand ?? this.brand,
    model: model ?? this.model,
    unitId: unitId ?? this.unitId,
    currencyId: currencyId ?? this.currencyId,
    sellingPrice:
    sellingPrice ?? this.sellingPrice,
    mrp: mrp ?? this.mrp,
    costPrice:
    costPrice ?? this.costPrice,
    stockQuantity:
    stockQuantity ?? this.stockQuantity,
    minimumStock:
    minimumStock ?? this.minimumStock,
    maximumStock:
    maximumStock ?? this.maximumStock,
    weight: weight ?? this.weight,
    length: length ?? this.length,
    width: width ?? this.width,
    height: height ?? this.height,
    thumbnailUrl:
    thumbnailUrl ?? this.thumbnailUrl,
    galleryImages:
    galleryImages ?? this.galleryImages,
    imageCount:
    imageCount ?? this.imageCount,
    isFeatured:
    isFeatured ?? this.isFeatured,
    isActive:
    isActive ?? this.isActive,
    createdAt:
    createdAt ?? this.createdAt,
    updatedAt:
    updatedAt ?? this.updatedAt,
    createdBy:
    createdBy ?? this.createdBy,
    updatedBy:
    updatedBy ?? this.updatedBy,
    deletedAt:
    deletedAt ?? this.deletedAt,
  );
}
}
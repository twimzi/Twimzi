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

  final bool isFeatured;
  final bool isActive;

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
      mrp: (json['mrp'] ?? 0).toDouble(),
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
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
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
      'is_featured': isFeatured,
      'is_active': isActive,
    };
  }
}
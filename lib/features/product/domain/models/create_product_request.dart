import 'dart:io';

class CreateProductRequest {
  final String businessId;
  final String? categoryId;

  final String productName;
  final String productCode;
  final String sku;
  final String? barcode;

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

  final File? thumbnail;

  const CreateProductRequest({
    required this.businessId,
    this.categoryId,
    required this.productName,
    required this.productCode,
    required this.sku,
    this.barcode,
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
    this.thumbnail,
  });
}
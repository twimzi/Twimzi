import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/product_repository.dart';
import 'product_provider.dart';

final productRegistrationProvider = StateNotifierProvider<
    ProductRegistrationNotifier,
    ProductRegistrationState>(
      (ref) => ProductRegistrationNotifier(
    ref.read(productRepositoryProvider),
  ),
);

class ProductRegistrationNotifier
    extends StateNotifier<ProductRegistrationState> {
  ProductRegistrationNotifier(
      this._repository,
      ) : super(
    ProductRegistrationState.initial(),
  );

  final ProductRepository _repository;

  void updateBasicInfo({
    required String productName,
    required String productCode,
    required String sku,
    String? barcode,
    required String shortDescription,
    required String description,
    String? brand,
    String? model,
    String? categoryId,
  }) {
    state = state.copyWith(
      productName: productName,
      productCode: productCode,
      sku: sku,
      barcode: barcode,
      shortDescription: shortDescription,
      description: description,
      brand: brand,
      model: model,
      categoryId: categoryId,
    );
  }

  void updatePricing({
    required double sellingPrice,
    required double mrp,
    required double costPrice,
    String? currencyId,
  }) {
    state = state.copyWith(
      sellingPrice: sellingPrice,
      mrp: mrp,
      costPrice: costPrice,
      currencyId: currencyId,
    );
  }

  void updateInventory({
    required int stockQuantity,
    required int minimumStock,
    required int maximumStock,
    String? unitId,
  }) {
    state = state.copyWith(
      stockQuantity: stockQuantity,
      minimumStock: minimumStock,
      maximumStock: maximumStock,
      unitId: unitId,
    );
  }

  void updateDimensions({
    required double weight,
    required double length,
    required double width,
    required double height,
  }) {
    state = state.copyWith(
      weight: weight,
      length: length,
      width: width,
      height: height,
    );
  }

  void updateThumbnail(
      File? image,
      ) {
    state = state.copyWith(
      thumbnail: image,
    );
  }

  void updateFlags({
    required bool isFeatured,
    required bool isActive,
  }) {
    state = state.copyWith(
      isFeatured: isFeatured,
      isActive: isActive,
    );
  }

  Future<void> submit() async {
    // Cloudflare R2 upload and ProductRepository.createProduct()
    // will be connected after the media pipeline is completed.
  }

  void reset() {
    state = ProductRegistrationState.initial();
  }
}

class ProductRegistrationState {
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

  const ProductRegistrationState({
    this.categoryId,
    this.productName = '',
    this.productCode = '',
    this.sku = '',
    this.barcode,
    this.shortDescription = '',
    this.description = '',
    this.brand,
    this.model,
    this.unitId,
    this.currencyId,
    this.sellingPrice = 0,
    this.mrp = 0,
    this.costPrice = 0,
    this.stockQuantity = 0,
    this.minimumStock = 0,
    this.maximumStock = 0,
    this.weight = 0,
    this.length = 0,
    this.width = 0,
    this.height = 0,
    this.isFeatured = false,
    this.isActive = true,
    this.thumbnail,
  });

  factory ProductRegistrationState.initial() =>
      const ProductRegistrationState();

  ProductRegistrationState copyWith({
    String? categoryId,
    String? productName,
    String? productCode,
    String? sku,
    String? barcode,
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
    bool? isFeatured,
    bool? isActive,
    File? thumbnail,
  }) {
    return ProductRegistrationState(
      categoryId: categoryId ?? this.categoryId,
      productName: productName ?? this.productName,
      productCode: productCode ?? this.productCode,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      shortDescription:
      shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      unitId: unitId ?? this.unitId,
      currencyId: currencyId ?? this.currencyId,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      mrp: mrp ?? this.mrp,
      costPrice: costPrice ?? this.costPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minimumStock: minimumStock ?? this.minimumStock,
      maximumStock: maximumStock ?? this.maximumStock,
      weight: weight ?? this.weight,
      length: length ?? this.length,
      width: width ?? this.width,
      height: height ?? this.height,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
}
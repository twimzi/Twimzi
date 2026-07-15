import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/create_product_request.dart';
import '../../domain/usecases/create_product_usecase.dart';
import 'product_provider.dart';

final createProductUseCaseProvider =
Provider<CreateProductUseCase>(
      (ref) => CreateProductUseCase(
    ref.read(productRepositoryProvider),
  ),
);

final productRegistrationProvider =
StateNotifierProvider<
    ProductRegistrationNotifier,
    ProductRegistrationState>(
      (ref) => ProductRegistrationNotifier(
    ref,
    ref.read(createProductUseCaseProvider),
  ),
);

class ProductRegistrationNotifier
    extends StateNotifier<ProductRegistrationState> {
  ProductRegistrationNotifier(
      this._ref,
      this._createProduct,
      ) : super(
    ProductRegistrationState.initial(),
  );

  final Ref _ref;
  final CreateProductUseCase _createProduct;

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
      productName: productName.trim(),
      productCode: productCode.trim(),
      sku: sku.trim(),
      barcode: _emptyToNull(barcode),
      shortDescription: shortDescription.trim(),
      description: description.trim(),
      brand: _emptyToNull(brand),
      model: _emptyToNull(model),
      categoryId: _emptyToNull(categoryId),
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
      currencyId: _emptyToNull(currencyId),
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
      unitId: _emptyToNull(unitId),
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

  void updateFlags({
    required bool isFeatured,
    required bool isActive,
  }) {
    state = state.copyWith(
      isFeatured: isFeatured,
      isActive: isActive,
    );
  }

  void updateThumbnail(
      File? image,
      ) {
    state = state.copyWith(
      thumbnail: image,
    );
  }

  void updateGalleryImages(
      List<File> images,
      ) {
    state = state.copyWith(
      galleryImages: images,
    );
  }

  void addGalleryImage(
      File image,
      ) {
    final images = List<File>.from(
      state.galleryImages,
    );

    images.add(image);

    state = state.copyWith(
      galleryImages: images,
    );
  }

  void removeGalleryImage(
      int index,
      ) {
    final images = List<File>.from(
      state.galleryImages,
    );

    if (index < 0 || index >= images.length) {
      return;
    }

    images.removeAt(index);

    state = state.copyWith(
      galleryImages: images,
    );
  }

  void clearGalleryImages() {
    state = state.copyWith(
      galleryImages: const [],
    );
  }

  Future<void> submit({
    required String businessId,
  }) async {
    final request = state.toRequest(
      businessId: businessId,
    );

    await _createProduct(request);

    _ref.invalidate(productsProvider);

    _ref.invalidate(
      businessProductsProvider(
        businessId,
      ),
    );

    _ref.invalidate(
      watchProductsProvider,
    );

    _ref.invalidate(
      watchBusinessProductsProvider(
        businessId,
      ),
    );
  }

  void reset() {
    state = ProductRegistrationState.initial();
  }

  String? _emptyToNull(
      String? value,
      ) {
    final trimmed = value?.trim();

    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }

    return trimmed;
  }
}
class ProductRegistrationState {
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
    this.galleryImages = const [],
  });

  factory ProductRegistrationState.initial() =>
      const ProductRegistrationState();

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
  final List<File> galleryImages;

  CreateProductRequest toRequest({
    required String businessId,
  }) {
    return CreateProductRequest(
      businessId: businessId,
      categoryId: categoryId,
      productName: productName,
      productCode: productCode,
      sku: sku,
      barcode: barcode,
      shortDescription: shortDescription,
      description: description,
      brand: brand,
      model: model,
      unitId: unitId,
      currencyId: currencyId,
      sellingPrice: sellingPrice,
      mrp: mrp,
      costPrice: costPrice,
      stockQuantity: stockQuantity,
      minimumStock: minimumStock,
      maximumStock: maximumStock,
      weight: weight,
      length: length,
      width: width,
      height: height,
      isFeatured: isFeatured,
      isActive: isActive,
      thumbnail: thumbnail,
      galleryImages: galleryImages,
    );
  }

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
    List<File>? galleryImages,
  }) {
    return ProductRegistrationState(
      categoryId: categoryId ?? this.categoryId,
      productName: productName ?? this.productName,
      productCode: productCode ?? this.productCode,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
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
      isFeatured:
      isFeatured ?? this.isFeatured,
      isActive:
      isActive ?? this.isActive,
      thumbnail:
      thumbnail ?? this.thumbnail,
      galleryImages:
      galleryImages ?? this.galleryImages,
    );
  }
}
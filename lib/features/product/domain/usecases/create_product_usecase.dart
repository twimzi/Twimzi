import '../../data/repositories/product_repository.dart';
import '../models/create_product_request.dart';

class CreateProductUseCase {
  const CreateProductUseCase(
      this._repository,
      );

  final ProductRepository _repository;

  Future<String> call(
      CreateProductRequest request,
      ) async {
    _validate(request);

    return _repository.createProduct(
      request,
    );
  }

  void _validate(
      CreateProductRequest request,
      ) {
    if (request.businessId.trim().isEmpty) {
      throw Exception(
        'Business is required.',
      );
    }

    if (request.productName.trim().isEmpty) {
      throw Exception(
        'Product name is required.',
      );
    }

    if (request.productCode.trim().isEmpty) {
      throw Exception(
        'Product code is required.',
      );
    }

    if (request.sku.trim().isEmpty) {
      throw Exception(
        'SKU is required.',
      );
    }

    if (request.sellingPrice < 0) {
      throw Exception(
        'Selling price cannot be negative.',
      );
    }

    if (request.costPrice < 0) {
      throw Exception(
        'Cost price cannot be negative.',
      );
    }

    if (request.stockQuantity < 0) {
      throw Exception(
        'Stock quantity cannot be negative.',
      );
    }

    if (request.minimumStock < 0) {
      throw Exception(
        'Minimum stock cannot be negative.',
      );
    }

    if (request.maximumStock < request.minimumStock) {
      throw Exception(
        'Maximum stock must be greater than minimum stock.',
      );
    }
  }
}
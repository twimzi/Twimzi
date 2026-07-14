import '../../data/repositories/product_repository.dart';
import '../models/create_product_request.dart';

class CreateProductUseCase {
  const CreateProductUseCase(this._repository);

  final ProductRepository _repository;

  Future<String> call(CreateProductRequest request) async {
    final validationError = validate(request);

    if (validationError != null) {
      throw ArgumentError(validationError);
    }

    return _repository.createProduct(request);
  }

  String? validate(CreateProductRequest request) {
    if (request.businessId.trim().isEmpty) {
      return 'Business is required.';
    }

    if (request.productName.trim().isEmpty) {
      return 'Product name is required.';
    }

    if (request.productCode.trim().isEmpty) {
      return 'Product code is required.';
    }

    if (request.sku.trim().isEmpty) {
      return 'SKU is required.';
    }

    if (request.shortDescription.trim().isEmpty) {
      return 'Short description is required.';
    }

    if (request.description.trim().isEmpty) {
      return 'Description is required.';
    }

    if (request.sellingPrice <= 0) {
      return 'Selling price must be greater than zero.';
    }

    if (request.mrp < request.sellingPrice) {
      return 'MRP cannot be less than selling price.';
    }

    if (request.costPrice < 0) {
      return 'Cost price cannot be negative.';
    }

    if (request.stockQuantity < 0) {
      return 'Stock quantity cannot be negative.';
    }

    if (request.minimumStock < 0) {
      return 'Minimum stock cannot be negative.';
    }

    if (request.maximumStock < request.minimumStock) {
      return 'Maximum stock cannot be less than minimum stock.';
    }

    if (request.weight < 0 ||
        request.length < 0 ||
        request.width < 0 ||
        request.height < 0) {
      return 'Dimensions cannot be negative.';
    }

    return null;
  }
}

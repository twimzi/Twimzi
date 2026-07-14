import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/create_product_request.dart';
import '../models/product_model.dart';

class ProductRepository {
  ProductRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  Future<List<ProductModel>> getProducts() async {
    final response = await _client
        .from('products')
        .select()
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

    return ProductModel.fromJson(response);
  }

  Future<String> createProduct(
      CreateProductRequest request,
      ) async {
    final slug = request.productName
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');

    final response = await _client
        .from('products')
        .insert({
      'business_id': request.businessId,
      'category_id': request.categoryId,
      'product_code': request.productCode,
      'sku': request.sku,
      'barcode': request.barcode,
      'product_name': request.productName,
      'slug': slug,
      'short_description': request.shortDescription,
      'description': request.description,
      'brand': request.brand,
      'model': request.model,
      'unit_id': request.unitId,
      'currency_id': request.currencyId,
      'selling_price': request.sellingPrice,
      'mrp': request.mrp,
      'cost_price': request.costPrice,
      'stock_quantity': request.stockQuantity,
      'minimum_stock': request.minimumStock,
      'maximum_stock': request.maximumStock,
      'weight': request.weight,
      'length': request.length,
      'width': request.width,
      'height': request.height,
      'is_featured': request.isFeatured,
      'is_active': request.isActive,
    })
        .select('id')
        .single();

    return response['id'] as String;
  }

  Future<void> updateProduct(
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

  Future<void> deleteProduct(
      String id,
      ) async {
    await _client
        .from('products')
        .update({
      'deleted_at': DateTime.now().toIso8601String(),
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
        .select('id');

    return (response as List).length;
  }

  Stream<List<ProductModel>> watchProducts() {
    return _client
        .from('products')
        .stream(
      primaryKey: ['id'],
    )
        .order('product_name')
        .map(
          (rows) => rows
          .map(
            (row) => ProductModel.fromJson(row),
      )
          .toList(),
    );
  }

  Stream<List<ProductModel>> watchBusinessProducts(
      String businessId,
      ) {
    return _client
        .from('products')
        .stream(
      primaryKey: ['id'],
    )
        .eq(
      'business_id',
      businessId,
    )
        .order('product_name')
        .map(
          (rows) => rows
          .map(
            (row) => ProductModel.fromJson(row),
      )
          .toList(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product_model.dart';
import '../providers/product_registration_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/add_product/gallery_picker.dart';
import '../widgets/add_product/product_basic_information_card.dart';
import '../widgets/add_product/product_dimensions_card.dart';
import '../widgets/add_product/product_inventory_card.dart';
import '../widgets/add_product/product_pricing_card.dart';
import '../widgets/add_product/product_status_card.dart';
import '../widgets/add_product/product_submit_button.dart';
import '../widgets/add_product/thumbnail_picker.dart';
import '../../domain/models/create_product_request.dart';

class EditProductPage extends ConsumerStatefulWidget {
  const EditProductPage({
    super.key,
    required this.productId,
    required this.businessId,
  });

  final String productId;
  final String businessId;

  @override
  ConsumerState<EditProductPage> createState() =>
      _EditProductPageState();
}

class _EditProductPageState
    extends ConsumerState<EditProductPage> {
final _formKey = GlobalKey<FormState>();

late final TextEditingController _productNameController;
late final TextEditingController _productCodeController;
late final TextEditingController _skuController;
late final TextEditingController _barcodeController;
late final TextEditingController _brandController;
late final TextEditingController _modelController;
late final TextEditingController _shortDescriptionController;
late final TextEditingController _descriptionController;

late final TextEditingController _sellingPriceController;
late final TextEditingController _mrpController;
late final TextEditingController _costPriceController;

late final TextEditingController _stockController;
late final TextEditingController _minimumStockController;
late final TextEditingController _maximumStockController;

late final TextEditingController _weightController;
late final TextEditingController _lengthController;
late final TextEditingController _widthController;
late final TextEditingController _heightController;

bool _loading = false;

ProductModel? _product;
@override
void initState() {
super.initState();

_productNameController = TextEditingController();
_productCodeController = TextEditingController();
_skuController = TextEditingController();
_barcodeController = TextEditingController();

_brandController = TextEditingController();
_modelController = TextEditingController();

_shortDescriptionController =
TextEditingController();

_descriptionController =
TextEditingController();

_sellingPriceController =
TextEditingController();

_mrpController =
TextEditingController();

_costPriceController =
TextEditingController();

_stockController =
TextEditingController();

_minimumStockController =
TextEditingController();

_maximumStockController =
TextEditingController();

_weightController =
TextEditingController();

_lengthController =
TextEditingController();

_widthController =
TextEditingController();

_heightController =
TextEditingController();

WidgetsBinding.instance.addPostFrameCallback((_) {
_loadProduct();
});
}

void _loadProduct() {
final productAsync = ref.read(
productProvider(widget.productId),
);

productAsync.whenData((product) {
_product = product;

_productNameController.text =
product.productName;

_productCodeController.text =
product.productCode;

_skuController.text =
product.sku;

_barcodeController.text =
product.barcode ?? '';

_brandController.text =
product.brand ?? '';

_modelController.text =
product.model ?? '';

_shortDescriptionController.text =
product.shortDescription;

_descriptionController.text =
product.description;

_sellingPriceController.text =
product.sellingPrice.toString();

_mrpController.text =
product.mrp.toString();

_costPriceController.text =
product.costPrice.toString();

_stockController.text =
product.stockQuantity.toString();

_minimumStockController.text =
product.minimumStock.toString();

_maximumStockController.text =
product.maximumStock.toString();

_weightController.text =
product.weight.toString();

_lengthController.text =
product.length.toString();

_widthController.text =
product.width.toString();

_heightController.text =
product.height.toString();

ref
.read(
productRegistrationProvider.notifier,
)
.updateFlags(
isFeatured: product.isFeatured,
isActive: product.isActive,
);

if (mounted) {
setState(() {});
}
});
}

@override
void dispose() {
_productNameController.dispose();
_productCodeController.dispose();
_skuController.dispose();
_barcodeController.dispose();

_brandController.dispose();
_modelController.dispose();

_shortDescriptionController.dispose();
_descriptionController.dispose();

_sellingPriceController.dispose();
_mrpController.dispose();
_costPriceController.dispose();

_stockController.dispose();
_minimumStockController.dispose();
_maximumStockController.dispose();

_weightController.dispose();
_lengthController.dispose();
_widthController.dispose();
_heightController.dispose();

super.dispose();
}
double _toDouble(
TextEditingController controller,
) {
return double.tryParse(
controller.text.trim(),
) ??
0;
}

int _toInt(
TextEditingController controller,
) {
return int.tryParse(
controller.text.trim(),
) ??
0;
}
Future<void> _submitUpdate() async {
  final registrationState = ref.read(
    productRegistrationProvider,
  );
if (!_formKey.currentState!.validate()) {
return;
}

if (_product == null) {
return;
}

setState(() {
_loading = true;
});

try {
final notifier = ref.read(
productRegistrationProvider.notifier,
);

notifier.updateBasicInfo(
productName: _productNameController.text,
productCode: _productCodeController.text,
sku: _skuController.text,
barcode: _barcodeController.text,
shortDescription:
_shortDescriptionController.text,
description:
_descriptionController.text,
brand: _brandController.text,
model: _modelController.text,
);

notifier.updatePricing(
sellingPrice: _toDouble(
_sellingPriceController,
),
mrp: _toDouble(
_mrpController,
),
costPrice: _toDouble(
_costPriceController,
),
);

notifier.updateInventory(
stockQuantity: _toInt(
_stockController,
),
minimumStock: _toInt(
_minimumStockController,
),
maximumStock: _toInt(
_maximumStockController,
),
);

notifier.updateDimensions(
weight: _toDouble(
_weightController,
),
length: _toDouble(
_lengthController,
),
width: _toDouble(
_widthController,
),
height: _toDouble(
_heightController,
),
);

final repository = ref.read(
  productRepositoryProvider,
);

final updatedProduct = _product!.copyWith(
  productName: _productNameController.text.trim(),
  productCode: _productCodeController.text.trim(),
  sku: _skuController.text.trim(),
  barcode: _barcodeController.text.trim().isEmpty
      ? null
      : _barcodeController.text.trim(),
  brand: _brandController.text.trim().isEmpty
      ? null
      : _brandController.text.trim(),
  model: _modelController.text.trim().isEmpty
      ? null
      : _modelController.text.trim(),
  shortDescription:
  _shortDescriptionController.text.trim(),
  description:
  _descriptionController.text.trim(),
  sellingPrice: _toDouble(
    _sellingPriceController,
  ),
  mrp: _toDouble(
    _mrpController,
  ),
  costPrice: _toDouble(
    _costPriceController,
  ),
  stockQuantity: _toInt(
    _stockController,
  ),
  minimumStock: _toInt(
    _minimumStockController,
  ),
  maximumStock: _toInt(
    _maximumStockController,
  ),
  weight: _toDouble(
    _weightController,
  ),
  length: _toDouble(
    _lengthController,
  ),
  width: _toDouble(
    _widthController,
  ),
  height: _toDouble(
    _heightController,
  ),
  isFeatured:
  registrationState.isFeatured,
  isActive:
  registrationState.isActive,
  updatedAt: DateTime.now(),
);

final imageRequest =
CreateProductRequest(
  businessId: widget.businessId,
  categoryId: updatedProduct.categoryId,
  productName:
  updatedProduct.productName,
  productCode:
  updatedProduct.productCode,
  sku: updatedProduct.sku,
  barcode: updatedProduct.barcode,
  shortDescription:
  updatedProduct.shortDescription,
  description:
  updatedProduct.description,
  brand: updatedProduct.brand,
  model: updatedProduct.model,
  unitId: updatedProduct.unitId,
  currencyId:
  updatedProduct.currencyId,
  sellingPrice:
  updatedProduct.sellingPrice,
  mrp: updatedProduct.mrp,
  costPrice:
  updatedProduct.costPrice,
  stockQuantity:
  updatedProduct.stockQuantity,
  minimumStock:
  updatedProduct.minimumStock,
  maximumStock:
  updatedProduct.maximumStock,
  weight: updatedProduct.weight,
  length: updatedProduct.length,
  width: updatedProduct.width,
  height: updatedProduct.height,
  isFeatured:
  updatedProduct.isFeatured,
  isActive:
  updatedProduct.isActive,
  thumbnail:
  registrationState.thumbnail,
  galleryImages:
  registrationState.galleryImages,
);

await repository.updateProduct(
  product: updatedProduct,
  request: imageRequest,
);

ref.invalidate(productsProvider);

ref.invalidate(
  businessProductsProvider(
    widget.businessId,
  ),
);

ref.invalidate(
  watchProductsProvider,
);

ref.invalidate(
  watchBusinessProductsProvider(
    widget.businessId,
  ),
);

if (!mounted) {
return;
}

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Product updated successfully.',
),
),
);

Navigator.pop(context);
} catch (e) {
if (!mounted) {
return;
}

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
e.toString(),
),
),
);
} finally {
if (mounted) {
setState(() {
_loading = false;
});
}
}
}
@override
Widget build(BuildContext context) {
  final registrationState = ref.read(
    productRegistrationProvider,
  );
  ref.watch(productRegistrationProvider);

  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Edit Product',
      ),
      centerTitle: true,
    ),
    body: SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [

              ProductBasicInformationCard(
                productNameController:
                _productNameController,
                productCodeController:
                _productCodeController,
                skuController:
                _skuController,
                barcodeController:
                _barcodeController,
                brandController:
                _brandController,
                modelController:
                _modelController,
                shortDescriptionController:
                _shortDescriptionController,
                descriptionController:
                _descriptionController,
              ),

              const SizedBox(height: 20),

              ProductPricingCard(
                sellingPriceController:
                _sellingPriceController,
                mrpController:
                _mrpController,
                costPriceController:
                _costPriceController,
              ),

              const SizedBox(height: 20),

              ProductInventoryCard(
                stockQuantityController:
                _stockController,
                minimumStockController:
                _minimumStockController,
                maximumStockController:
                _maximumStockController,
              ),

              const SizedBox(height: 20),

              ProductDimensionsCard(
                weightController:
                _weightController,
                lengthController:
                _lengthController,
                widthController:
                _widthController,
                heightController:
                _heightController,
              ),

              const SizedBox(height: 20),

              ThumbnailPicker(
                initialImage:
                registrationState.thumbnail,
                onChanged: (image) {
                  ref
                      .read(
                    productRegistrationProvider
                        .notifier,
                  )
                      .updateThumbnail(image);
                },
              ),

              const SizedBox(height: 20),

              GalleryPicker(
                initialImages:
                registrationState.galleryImages,
                onChanged: (images) {
                  ref
                      .read(
                    productRegistrationProvider
                        .notifier,
                  )
                      .updateGalleryImages(images);
                },
              ),

              const SizedBox(height: 20),

              ProductStatusCard(
                isFeatured:
                registrationState.isFeatured,
                isActive:
                registrationState.isActive,
                onFeaturedChanged: (value) {
                  ref
                      .read(
                    productRegistrationProvider
                        .notifier,
                  )
                      .updateFlags(
                    isFeatured: value,
                    isActive:
                    registrationState.isActive,
                  );
                },
                onActiveChanged: (value) {
                  ref
                      .read(
                    productRegistrationProvider
                        .notifier,
                  )
                      .updateFlags(
                    isFeatured:
                    registrationState.isFeatured,
                    isActive: value,
                  );
                },
              ),

              const SizedBox(height: 32),

              ProductSubmitButton(
                isLoading: _loading,
                label: 'Update Product',
                onSubmit: _submitUpdate,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    ),
  );
}
}
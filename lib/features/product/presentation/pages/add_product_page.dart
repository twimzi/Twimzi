import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_registration_provider.dart';

import '../widgets/add_product/gallery_picker.dart';
import '../widgets/add_product/product_basic_information_card.dart';
import '../widgets/add_product/product_dimensions_card.dart';
import '../widgets/add_product/product_inventory_card.dart';
import '../widgets/add_product/product_pricing_card.dart';
import '../widgets/add_product/product_status_card.dart';
import '../widgets/add_product/product_submit_button.dart';
import '../widgets/add_product/thumbnail_picker.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({
    super.key,
    required this.businessId,
  });

  final String businessId;

  @override
  ConsumerState<AddProductPage> createState() =>
      _AddProductPageState();
}

class _AddProductPageState
    extends ConsumerState<AddProductPage> {
final _formKey = GlobalKey<FormState>();

late final TextEditingController
_productNameController;

late final TextEditingController
_productCodeController;

late final TextEditingController
_skuController;

late final TextEditingController
_barcodeController;

late final TextEditingController
_brandController;

late final TextEditingController
_modelController;

late final TextEditingController
_shortDescriptionController;

late final TextEditingController
_descriptionController;

late final TextEditingController
_sellingPriceController;

late final TextEditingController
_mrpController;

late final TextEditingController
_costPriceController;

late final TextEditingController
_stockController;

late final TextEditingController
_minimumStockController;

late final TextEditingController
_maximumStockController;

late final TextEditingController
_weightController;

late final TextEditingController
_lengthController;

late final TextEditingController
_widthController;

late final TextEditingController
_heightController;

bool _loading = false;
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

_mrpController = TextEditingController();

_costPriceController =
TextEditingController();

_stockController = TextEditingController();

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
Future<void> _submit() async {
if (!_formKey.currentState!.validate()) {
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

await notifier.submit(
businessId: widget.businessId,
);

if (!mounted) {
return;
}

ScaffoldMessenger.of(context)
.showSnackBar(
const SnackBar(
content: Text(
'Product created successfully.',
),
),
);

_resetForm();
} catch (e) {
if (!mounted) {
return;
}

ScaffoldMessenger.of(context)
.showSnackBar(
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

void _resetForm() {
_formKey.currentState?.reset();

_productNameController.clear();
_productCodeController.clear();
_skuController.clear();
_barcodeController.clear();

_brandController.clear();
_modelController.clear();

_shortDescriptionController.clear();
_descriptionController.clear();

_sellingPriceController.clear();
_mrpController.clear();
_costPriceController.clear();

_stockController.clear();
_minimumStockController.clear();
_maximumStockController.clear();

_weightController.clear();
_lengthController.clear();
_widthController.clear();
_heightController.clear();

ref.read(
productRegistrationProvider.notifier,
).reset();
}
@override
Widget build(BuildContext context) {
  final registrationState =
  ref.watch(productRegistrationProvider);

  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Add Product',
      ),
    ),
    body: SafeArea(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
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

            ProductPricingCard(
              sellingPriceController:
              _sellingPriceController,
              mrpController:
              _mrpController,
              costPriceController:
              _costPriceController,
            ),

            ProductInventoryCard(
              stockQuantityController:
              _stockController,
              minimumStockController:
              _minimumStockController,
              maximumStockController:
              _maximumStockController,
            ),

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

            ThumbnailPicker(
              initialImage:
              registrationState.thumbnail,
              onChanged: (image) {
                ref
                    .read(
                  productRegistrationProvider
                      .notifier,
                )
                    .updateThumbnail(
                  image,
                );
              },
            ),

            const SizedBox(height: 16),

            GalleryPicker(
              initialImages:
              registrationState.galleryImages,
              onChanged: (images) {
                ref
                    .read(
                  productRegistrationProvider
                      .notifier,
                )
                    .updateGalleryImages(
                  images,
                );
              },
            ),

            const SizedBox(height: 16),

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
                  registrationState
                      .isActive,
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
                  registrationState
                      .isFeatured,
                  isActive: value,
                );
              },
            ),

            const SizedBox(height: 24),

            ProductSubmitButton(
              isLoading: _loading,
              label: 'Create Product',
              onSubmit: _submit,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
}
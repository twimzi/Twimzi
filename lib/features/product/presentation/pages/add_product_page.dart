import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_registration_provider.dart';

class AddProductPage extends ConsumerStatefulWidget {
  final String businessId;

  const AddProductPage({
    super.key,
    required this.businessId,
  });

  @override
  ConsumerState<AddProductPage> createState() =>
      _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final _productNameController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _skuController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _categoryController = TextEditingController();
  final _unitController = TextEditingController();
  final _currencyController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _mrpController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _stockQuantityController = TextEditingController();
  final _minimumStockController = TextEditingController();
  final _maximumStockController = TextEditingController();
  final _weightController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

  bool _isFeatured = false;
  bool _isActive = true;

  @override
  void dispose() {
    _productNameController.dispose();
    _productCodeController.dispose();
    _skuController.dispose();
    _barcodeController.dispose();
    _shortDescriptionController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _categoryController.dispose();
    _unitController.dispose();
    _currencyController.dispose();
    _sellingPriceController.dispose();
    _mrpController.dispose();
    _costPriceController.dispose();
    _stockQuantityController.dispose();
    _minimumStockController.dispose();
    _maximumStockController.dispose();
    _weightController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registrationState = ref.watch(productRegistrationProvider);

    ref.listen<ProductRegistrationState>(
      productRegistrationProvider,
          (previous, next) {
        final errorMessage = next.errorMessage;

        if (errorMessage != null &&
            errorMessage != previous?.errorMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (next.completed && previous?.completed != true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product created successfully.'),
            ),
          );

          Navigator.of(context).pop(true);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionTitle(context, 'Basic Information'),
            _textField(
              controller: _productNameController,
              label: 'Product Name',
              icon: Icons.inventory_2_outlined,
              requiredField: true,
            ),
            _textField(
              controller: _productCodeController,
              label: 'Product Code',
              icon: Icons.confirmation_number_outlined,
              requiredField: true,
            ),
            _textField(
              controller: _skuController,
              label: 'SKU',
              icon: Icons.qr_code_2_outlined,
              requiredField: true,
            ),
            _textField(
              controller: _barcodeController,
              label: 'Barcode',
              icon: Icons.document_scanner_outlined,
            ),
            _textField(
              controller: _categoryController,
              label: 'Category ID',
              icon: Icons.category_outlined,
            ),
            _textField(
              controller: _shortDescriptionController,
              label: 'Short Description',
              icon: Icons.short_text,
              requiredField: true,
            ),
            _textField(
              controller: _descriptionController,
              label: 'Description',
              icon: Icons.description_outlined,
              requiredField: true,
              maxLines: 4,
            ),
            _textField(
              controller: _brandController,
              label: 'Brand',
              icon: Icons.business_outlined,
            ),
            _textField(
              controller: _modelController,
              label: 'Model',
              icon: Icons.view_in_ar_outlined,
            ),
            const SizedBox(height: 16),
            _sectionTitle(context, 'Pricing'),
            _numberField(
              controller: _sellingPriceController,
              label: 'Selling Price',
              icon: Icons.sell_outlined,
              requiredField: true,
              allowDecimal: true,
              positiveOnly: true,
            ),
            _numberField(
              controller: _mrpController,
              label: 'MRP',
              icon: Icons.price_check_outlined,
              requiredField: true,
              allowDecimal: true,
              positiveOnly: true,
            ),
            _numberField(
              controller: _costPriceController,
              label: 'Cost Price',
              icon: Icons.payments_outlined,
              requiredField: true,
              allowDecimal: true,
            ),
            _textField(
              controller: _currencyController,
              label: 'Currency ID',
              icon: Icons.currency_rupee,
            ),
            const SizedBox(height: 16),
            _sectionTitle(context, 'Inventory'),
            _numberField(
              controller: _stockQuantityController,
              label: 'Stock Quantity',
              icon: Icons.inventory_outlined,
              requiredField: true,
            ),
            _numberField(
              controller: _minimumStockController,
              label: 'Minimum Stock',
              icon: Icons.remove_circle_outline,
              requiredField: true,
            ),
            _numberField(
              controller: _maximumStockController,
              label: 'Maximum Stock',
              icon: Icons.add_circle_outline,
              requiredField: true,
            ),
            _textField(
              controller: _unitController,
              label: 'Unit ID',
              icon: Icons.straighten_outlined,
            ),
            const SizedBox(height: 16),
            _sectionTitle(context, 'Dimensions'),
            _numberField(
              controller: _weightController,
              label: 'Weight',
              icon: Icons.scale_outlined,
              requiredField: true,
              allowDecimal: true,
            ),
            _numberField(
              controller: _lengthController,
              label: 'Length',
              icon: Icons.height_outlined,
              requiredField: true,
              allowDecimal: true,
            ),
            _numberField(
              controller: _widthController,
              label: 'Width',
              icon: Icons.width_normal_outlined,
              requiredField: true,
              allowDecimal: true,
            ),
            _numberField(
              controller: _heightController,
              label: 'Height',
              icon: Icons.vertical_align_top_outlined,
              requiredField: true,
              allowDecimal: true,
            ),
            const SizedBox(height: 16),
            _sectionTitle(context, 'Status'),
            SwitchListTile(
              value: _isFeatured,
              onChanged: registrationState.isSubmitting
                  ? null
                  : (value) {
                setState(() {
                  _isFeatured = value;
                });
              },
              title: const Text('Featured Product'),
            ),
            SwitchListTile(
              value: _isActive,
              onChanged: registrationState.isSubmitting
                  ? null
                  : (value) {
                setState(() {
                  _isActive = value;
                });
              },
              title: const Text('Active Product'),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: registrationState.isSubmitting
                  ? null
                  : _submit,
              icon: registrationState.isSubmitting
                  ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
                  : const Icon(Icons.save_outlined),
              label: Text(
                registrationState.isSubmitting
                    ? 'Saving Product...'
                    : 'Save Product',
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(
      BuildContext context,
      String title,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool requiredField = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        textInputAction:
        maxLines == 1 ? TextInputAction.next : TextInputAction.newline,
        decoration: InputDecoration(
          labelText: requiredField ? '$label *' : label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: requiredField
            ? (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label is required.';
          }

          return null;
        }
            : null,
      ),
    );
  }

  Widget _numberField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool requiredField = false,
    bool allowDecimal = false,
    bool positiveOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(
          decimal: allowDecimal,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            allowDecimal ? RegExp(r'^\d*\.?\d*') : RegExp(r'\d+'),
          ),
        ],
        decoration: InputDecoration(
          labelText: requiredField ? '$label *' : label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (requiredField && (value == null || value.trim().isEmpty)) {
            return '$label is required.';
          }

          if (value == null || value.trim().isEmpty) {
            return null;
          }

          final parsed = double.tryParse(value.trim());

          if (parsed == null) {
            return '$label must be a valid number.';
          }

          if (positiveOnly && parsed <= 0) {
            return '$label must be greater than zero.';
          }

          if (!positiveOnly && parsed < 0) {
            return '$label cannot be negative.';
          }

          return null;
        },
      ),
    );
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    final sellingPrice = _doubleValue(_sellingPriceController);
    final mrp = _doubleValue(_mrpController);
    final costPrice = _doubleValue(_costPriceController);
    final stockQuantity = _intValue(_stockQuantityController);
    final minimumStock = _intValue(_minimumStockController);
    final maximumStock = _intValue(_maximumStockController);
    final weight = _doubleValue(_weightController);
    final length = _doubleValue(_lengthController);
    final width = _doubleValue(_widthController);
    final height = _doubleValue(_heightController);

    ref
        .read(productRegistrationProvider.notifier)
      ..updateBasicInfo(
        productName: _productNameController.text,
        productCode: _productCodeController.text,
        sku: _skuController.text,
        barcode: _barcodeController.text,
        shortDescription: _shortDescriptionController.text,
        description: _descriptionController.text,
        brand: _brandController.text,
        model: _modelController.text,
        categoryId: _categoryController.text,
      )
      ..updatePricing(
        sellingPrice: sellingPrice,
        mrp: mrp,
        costPrice: costPrice,
        currencyId: _currencyController.text,
      )
      ..updateInventory(
        stockQuantity: stockQuantity,
        minimumStock: minimumStock,
        maximumStock: maximumStock,
        unitId: _unitController.text,
      )
      ..updateDimensions(
        weight: weight,
        length: length,
        width: width,
        height: height,
      )
      ..updateFlags(
        isFeatured: _isFeatured,
        isActive: _isActive,
      );

    await ref.read(productRegistrationProvider.notifier).submit(
      businessId: widget.businessId,
    );
  }

  double _doubleValue(TextEditingController controller) {
    return double.tryParse(controller.text.trim()) ?? 0;
  }

  int _intValue(TextEditingController controller) {
    return int.tryParse(controller.text.trim()) ?? 0;
  }
}

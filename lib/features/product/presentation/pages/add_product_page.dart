import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product_model.dart';
import '../providers/product_registration_provider.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({
    super.key,
    required this.businessId,
    this.product,
    this.isEdit = false,
  });

  final String businessId;
  final ProductModel? product;
  final bool isEdit;

  @override
  ConsumerState<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  // Basic Information
  late final TextEditingController _productNameController;
  late final TextEditingController _productCodeController;
  late final TextEditingController _skuController;
  late final TextEditingController _barcodeController;
  late final TextEditingController _shortDescriptionController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _brandController;
  late final TextEditingController _modelController;

  // Category
  String? _categoryId;

  // Pricing
  late final TextEditingController _sellingPriceController;
  late final TextEditingController _mrpController;
  late final TextEditingController _costPriceController;
  String? _currencyId;

  // Inventory
  late final TextEditingController _stockController;
  late final TextEditingController _minimumStockController;
  late final TextEditingController _maximumStockController;
  String? _unitId;

  // Dimensions
  late final TextEditingController _weightController;
  late final TextEditingController _lengthController;
  late final TextEditingController _widthController;
  late final TextEditingController _heightController;

  // Status
  bool _isFeatured = false;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    if (widget.isEdit && widget.product != null) {
      _populateFormWithProduct(widget.product!);
    }
  }

  void _initializeControllers() {
    _productNameController = TextEditingController();
    _productCodeController = TextEditingController();
    _skuController = TextEditingController();
    _barcodeController = TextEditingController();
    _shortDescriptionController = TextEditingController();
    _descriptionController = TextEditingController();
    _brandController = TextEditingController();
    _modelController = TextEditingController();
    _sellingPriceController = TextEditingController();
    _mrpController = TextEditingController();
    _costPriceController = TextEditingController();
    _stockController = TextEditingController();
    _minimumStockController = TextEditingController();
    _maximumStockController = TextEditingController();
    _weightController = TextEditingController();
    _lengthController = TextEditingController();
    _widthController = TextEditingController();
    _heightController = TextEditingController();
  }

  void _populateFormWithProduct(ProductModel product) {
    // TODO: Implement form population logic
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit Product' : 'Add Product',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildBasicInformationCard(),
            const SizedBox(height: 20),
            _buildPricingCard(),
            const SizedBox(height: 20),
            _buildInventoryCard(),
            const SizedBox(height: 20),
            _buildDimensionsCard(),
            const SizedBox(height: 20),
            _buildStatusCard(),
            const SizedBox(height: 30),
            _buildSubmitButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInformationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(
                labelText: 'Product Name *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.inventory_2_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Product Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _productCodeController,
              decoration: const InputDecoration(
                labelText: 'Product Code *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.qr_code),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Product Code is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _skuController,
              decoration: const InputDecoration(
                labelText: 'SKU *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.confirmation_number_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'SKU is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _barcodeController,
              decoration: const InputDecoration(
                labelText: 'Barcode',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.document_scanner_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _brandController,
              decoration: const InputDecoration(
                labelText: 'Brand',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.business_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _modelController,
              decoration: const InputDecoration(
                labelText: 'Model',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.widgets_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _shortDescriptionController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Short Description *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.short_text),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Short Description is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description *',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pricing',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _sellingPriceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Selling Price *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.sell_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Selling Price is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Invalid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _mrpController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'MRP *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'MRP is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Invalid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _costPriceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Cost Price',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.payments_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (double.tryParse(value) == null) {
                  return 'Invalid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _currencyId,
              decoration: const InputDecoration(
                labelText: 'Currency',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_exchange),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'INR',
                  child: Text('Indian Rupee'),
                ),
                DropdownMenuItem(
                  value: 'USD',
                  child: Text('US Dollar'),
                ),
                DropdownMenuItem(
                  value: 'CAD',
                  child: Text('Canadian Dollar'),
                ),
                DropdownMenuItem(
                  value: 'EUR',
                  child: Text('Euro'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _currencyId = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inventory',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stock Quantity *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.inventory_2_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Stock Quantity is required';
                }
                if (int.tryParse(value) == null) {
                  return 'Invalid quantity';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _minimumStockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Minimum Stock',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.remove_circle_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (int.tryParse(value) == null) {
                  return 'Invalid quantity';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _maximumStockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Maximum Stock',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.add_circle_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (int.tryParse(value) == null) {
                  return 'Invalid quantity';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _unitId,
              decoration: const InputDecoration(
                labelText: 'Unit',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.straighten),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'PCS',
                  child: Text('Pieces'),
                ),
                DropdownMenuItem(
                  value: 'KG',
                  child: Text('Kilogram'),
                ),
                DropdownMenuItem(
                  value: 'GM',
                  child: Text('Gram'),
                ),
                DropdownMenuItem(
                  value: 'LTR',
                  child: Text('Litre'),
                ),
                DropdownMenuItem(
                  value: 'BOX',
                  child: Text('Box'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _unitId = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDimensionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dimensions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Weight',
                      border: OutlineInputBorder(),
                      suffixText: 'kg',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (double.tryParse(value) == null) {
                        return 'Invalid';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _lengthController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Length',
                      border: OutlineInputBorder(),
                      suffixText: 'cm',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (double.tryParse(value) == null) {
                        return 'Invalid';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _widthController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Width',
                      border: OutlineInputBorder(),
                      suffixText: 'cm',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (double.tryParse(value) == null) {
                        return 'Invalid';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _heightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Height',
                      border: OutlineInputBorder(),
                      suffixText: 'cm',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (double.tryParse(value) == null) {
                        return 'Invalid';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Product Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Featured Product'),
              subtitle: const Text('Display this product as featured.'),
              value: _isFeatured,
              onChanged: (value) {
                setState(() {
                  _isFeatured = value;
                });
              },
            ),
            const Divider(),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Active Product'),
              subtitle: const Text('Inactive products are hidden from customers.'),
              value: _isActive,
              onChanged: (value) {
                setState(() {
                  _isActive = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: _submit,
        icon: Icon(
          widget.isEdit ? Icons.save_outlined : Icons.add_circle_outline,
        ),
        label: Text(
          widget.isEdit ? 'Update Product' : 'Create Product',
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final notifier = ref.read(productRegistrationProvider.notifier);

    notifier.updateBasicInfo(
      productName: _productNameController.text.trim(),
      productCode: _productCodeController.text.trim(),
      sku: _skuController.text.trim(),
      barcode: _barcodeController.text.trim().isEmpty
          ? null
          : _barcodeController.text.trim(),
      shortDescription: _shortDescriptionController.text.trim(),
      description: _descriptionController.text.trim(),
      brand: _brandController.text.trim().isEmpty ? null : _brandController.text.trim(),
      model: _modelController.text.trim().isEmpty ? null : _modelController.text.trim(),
      categoryId: _categoryId,
    );

    notifier.updatePricing(
      sellingPrice: double.tryParse(_sellingPriceController.text) ?? 0,
      mrp: double.tryParse(_mrpController.text) ?? 0,
      costPrice: double.tryParse(_costPriceController.text) ?? 0,
      currencyId: _currencyId,
    );

    notifier.updateInventory(
      stockQuantity: int.tryParse(_stockController.text) ?? 0,
      minimumStock: int.tryParse(_minimumStockController.text) ?? 0,
      maximumStock: int.tryParse(_maximumStockController.text) ?? 0,
      unitId: _unitId,
    );

    notifier.updateDimensions(
      weight: double.tryParse(_weightController.text) ?? 0,
      length: double.tryParse(_lengthController.text) ?? 0,
      width: double.tryParse(_widthController.text) ?? 0,
      height: double.tryParse(_heightController.text) ?? 0,
    );

    notifier.updateFlags(
      isFeatured: _isFeatured,
      isActive: _isActive,
    );

    await notifier.submit(
      businessId: widget.businessId,
    );

    if (!mounted) return;

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEdit
                ? 'Product updated successfully.'
                : 'Product saved successfully.',
          ),
        ),
      );

      Navigator.pop(context, true);
    }
  }
}

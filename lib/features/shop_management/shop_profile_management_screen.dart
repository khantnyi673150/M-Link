import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../../core/theme/app_theme.dart';
import '../../models/menu_item.dart';
import '../../models/shop_model.dart';
import '../../services/cloudinary_service.dart';
import '../../services/shop_service.dart';

class ShopProfileManagementScreen extends StatefulWidget {
  final String merchantId;
  final Shop? existingShop;

  const ShopProfileManagementScreen({
    super.key,
    required this.merchantId,
    this.existingShop,
  });

  @override
  State<ShopProfileManagementScreen> createState() =>
      _ShopProfileManagementScreenState();
}

class _ShopProfileManagementScreenState
    extends State<ShopProfileManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _menuFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceRangeController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _imagePicker = ImagePicker();

  final _menuNameController = TextEditingController();
  final _menuDescriptionController = TextEditingController();
  final _menuPriceController = TextEditingController();

  static const List<String> _categories = [
    'Food',
    'Rentals',
    'Optical Shops',
    'Repairs',
    'Fashion',
    'Stationery',
    'Health',
    'Transport',
  ];

  String _selectedCategory = _categories.first;
  String? _shopId;
  bool _hasChanges = false;
  bool _savingShop = false;
  bool _savingMenu = false;
  Uint8List? _selectedImageBytes;
  String? _existingImageUrl;

  bool get _hasShopImage =>
      _selectedImageBytes != null ||
      (_existingImageUrl != null && _existingImageUrl!.isNotEmpty);

  bool get _isShopFormValid =>
      _nameController.text.trim().isNotEmpty &&
      _descriptionController.text.trim().isNotEmpty &&
      _priceRangeController.text.trim().isNotEmpty &&
      _locationController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty &&
      _hasShopImage;

  bool get _isMenuFormValid {
    final price = double.tryParse(_menuPriceController.text.trim());
    return _menuNameController.text.trim().isNotEmpty &&
        _menuDescriptionController.text.trim().isNotEmpty &&
        price != null &&
        price > 0;
  }

  void _onFieldChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    final shop = widget.existingShop;
    if (shop != null) {
      _shopId = shop.id;
      _nameController.text = shop.name;
      _descriptionController.text = shop.description;
      _priceRangeController.text = shop.priceRange;
      _locationController.text = shop.location;
      _phoneController.text = shop.phone;
      _selectedCategory = _categories.contains(shop.category)
          ? shop.category
          : _categories.first;
      if (shop.imageUrls.isNotEmpty) {
        _existingImageUrl = shop.imageUrls.first;
      }
    }

    if (_shopId == null) {
      _hydrateExistingShopId();
    }

    _nameController.addListener(_onFieldChanged);
    _descriptionController.addListener(_onFieldChanged);
    _priceRangeController.addListener(_onFieldChanged);
    _locationController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
    _menuNameController.addListener(_onFieldChanged);
    _menuDescriptionController.addListener(_onFieldChanged);
    _menuPriceController.addListener(_onFieldChanged);
  }

  Future<void> _hydrateExistingShopId() async {
    final shop = await ShopService.getMerchantShop(widget.merchantId);
    if (!mounted || shop == null) return;
    setState(() => _shopId = shop.id);
  }

  @override
  void dispose() {
    _nameController.removeListener(_onFieldChanged);
    _descriptionController.removeListener(_onFieldChanged);
    _priceRangeController.removeListener(_onFieldChanged);
    _locationController.removeListener(_onFieldChanged);
    _phoneController.removeListener(_onFieldChanged);
    _menuNameController.removeListener(_onFieldChanged);
    _menuDescriptionController.removeListener(_onFieldChanged);
    _menuPriceController.removeListener(_onFieldChanged);

    _nameController.dispose();
    _descriptionController.dispose();
    _priceRangeController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _menuNameController.dispose();
    _menuDescriptionController.dispose();
    _menuPriceController.dispose();
    super.dispose();
  }

  Future<void> _pickShopPhoto() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
      maxWidth: 1400,
    );
    if (image == null) return;

    final bytes = await image.readAsBytes();
    if (!mounted) return;

    setState(() {
      _selectedImageBytes = bytes;
      _hasChanges = true;
    });
  }

  Future<Uint8List> _compressShopPhoto(Uint8List bytes) async {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return bytes;

    final resized = decoded.width > 1400
        ? img.copyResize(decoded, width: 1200)
        : decoded;

    return Uint8List.fromList(img.encodeJpg(resized, quality: 75));
  }

  Future<String?> _uploadShopPhotoIfNeeded() async {
    if (_selectedImageBytes == null) {
      return _existingImageUrl;
    }

    final compressedBytes = await _compressShopPhoto(_selectedImageBytes!);

    return CloudinaryService.uploadShopImage(
      imageBytes: compressedBytes,
      merchantId: widget.merchantId,
    ).timeout(const Duration(seconds: 20));
  }

  Widget _buildPhotoPicker() {
    final theme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final photoHeight = screenWidth < 700 ? 150.0 : 190.0;
    final preview = _selectedImageBytes != null
        ? Image.memory(
            _selectedImageBytes!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        : (_existingImageUrl != null && _existingImageUrl!.isNotEmpty)
        ? Image.network(
            _existingImageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        : Container(
            color: AppTheme.surfaceVariant,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.storefront_rounded,
                    size: 48,
                    color: AppTheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No shop photo selected',
                    style: theme.bodyMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: photoHeight,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: preview,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Shop Photo',
                  style: theme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Upload a clear, large photo from your device.',
                  style: theme.bodyMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _pickShopPhoto,
                  icon: const Icon(Icons.photo_library_outlined),
                  label: Text(
                    _selectedImageBytes == null
                        ? 'Upload Image'
                        : 'Change Photo',
                  ),
                ),
                if (_selectedImageBytes != null ||
                    _existingImageUrl != null) ...[
                  const SizedBox(height: 6),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedImageBytes = null;
                        _existingImageUrl = null;
                        _hasChanges = true;
                      });
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Remove photo'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveShop() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedImageBytes == null &&
        (_existingImageUrl == null || _existingImageUrl!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose a shop photo from your device.'),
        ),
      );
      return;
    }

    setState(() => _savingShop = true);
    try {
      final uploadedImageUrl = await _uploadShopPhotoIfNeeded();
      final imageUrls = uploadedImageUrl == null || uploadedImageUrl.isEmpty
          ? <String>[]
          : <String>[uploadedImageUrl];

      final savedShopId = await ShopService.upsertMerchantShop(
        merchantId: widget.merchantId,
        name: _nameController.text.trim(),
        category: _selectedCategory,
        description: _descriptionController.text.trim(),
        priceRange: _priceRangeController.text.trim(),
        location: _locationController.text.trim(),
        phone: _phoneController.text.trim(),
        imageUrls: imageUrls,
      );

      if (!mounted) return;
      setState(() {
        _shopId = savedShopId;
        _existingImageUrl = imageUrls.isNotEmpty
            ? imageUrls.first
            : _existingImageUrl;
        _selectedImageBytes = null;
        _hasChanges = true;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Shop profile saved.')));
    } on CloudinaryUploadException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } on TimeoutException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Photo upload took too long. Please try a smaller image.',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save shop profile.')),
      );
    } finally {
      if (mounted) {
        setState(() => _savingShop = false);
      }
    }
  }

  Future<void> _addMenuItem() async {
    if (!_menuFormKey.currentState!.validate()) return;

    final shop = await ShopService.getMerchantShop(widget.merchantId);
    if (!mounted) return;
    if (shop == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Save the shop profile first.')),
      );
      return;
    }

    final name = _menuNameController.text.trim();
    final description = _menuDescriptionController.text.trim();
    final price = double.parse(_menuPriceController.text.trim());

    setState(() => _savingMenu = true);
    try {
      await ShopService.addMenuItem(
        shopId: shop.id,
        name: name,
        description: description,
        price: price,
      );
      _menuNameController.clear();
      _menuDescriptionController.clear();
      _menuPriceController.clear();
      _hasChanges = true;
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Menu item added.')));
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_mapDataError(e, fallback: 'Failed to add menu item.')),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to add menu item.')));
    } finally {
      if (mounted) {
        setState(() => _savingMenu = false);
      }
    }
  }

  String _mapDataError(Exception e, {required String fallback}) {
    final message = e.toString().toLowerCase();
    if (message.contains('permission-denied')) {
      return 'Permission denied. Please login again and try.';
    }
    if (message.contains('unauthenticated')) {
      return 'You are not authenticated. Please login again.';
    }
    if (message.contains('unavailable')) {
      return 'Network unavailable. Please check connection.';
    }
    if (message.contains('deadline-exceeded')) {
      return 'Request timed out. Please try again.';
    }
    return fallback;
  }

  InputDecoration _compactInputDecoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  ButtonStyle get _compactPrimaryButtonStyle {
    return ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(44),
      padding: const EdgeInsets.symmetric(vertical: 10),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ).merge(AppTheme.merchantButtonStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        title: const Text('Shop Profile Management'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(_hasChanges),
            child: const Text('Done'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildShopFormCard(),
                const SizedBox(height: 16),
                if (_shopId != null) _buildMenuCard(_shopId!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShopFormCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: AppTheme.outline),
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPhotoPicker(),
            const SizedBox(height: 12),
            Text('Shop Info', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              decoration: _compactInputDecoration('Shop name'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Shop name is required'
                  : null,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              items: _categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCategory = value);
                }
              },
              decoration: _compactInputDecoration('Category'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: _compactInputDecoration('Description'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Description is required'
                  : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _priceRangeController,
              decoration: _compactInputDecoration(
                'Price range',
                hint: 'e.g. \$2 - \$10',
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Price range is required'
                  : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _locationController,
              decoration: _compactInputDecoration('Location'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Location is required'
                  : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _compactInputDecoration('Phone number'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Phone number is required'
                  : null,
            ),
            if (!_hasShopImage)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Please upload a shop image before saving.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: (!_savingShop && _isShopFormValid) ? _saveShop : null,
              style: _compactPrimaryButtonStyle,
              icon: _savingShop
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.save_rounded),
              label: Text(_savingShop ? 'Saving...' : 'Save Shop Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(String shopId) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: AppTheme.outline),
      ),
      child: Form(
        key: _menuFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Menu Management',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _menuNameController,
              decoration: _compactInputDecoration('Menu item name'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Menu item name is required'
                  : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _menuDescriptionController,
              decoration: _compactInputDecoration('Menu item description'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Menu description is required'
                  : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _menuPriceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: _compactInputDecoration('Price'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Price is required';
                }
                final parsed = double.tryParse(v.trim());
                if (parsed == null || parsed <= 0) {
                  return 'Enter a valid price greater than 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: (!_savingMenu && _isMenuFormValid)
                  ? _addMenuItem
                  : null,
              icon: const Icon(Icons.add_rounded),
              style: _compactPrimaryButtonStyle,
              label: Text(_savingMenu ? 'Adding...' : 'Add Menu Item'),
            ),
            const SizedBox(height: 12),
            StreamBuilder<List<MenuItem>>(
              stream: ShopService.streamMenuItems(shopId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return const Text('Failed to load menu items.');
                }

                final items = snapshot.data ?? const <MenuItem>[];
                if (items.isEmpty) {
                  return const Text('No menu items yet.');
                }

                return Column(
                  children: items
                      .map(
                        (item) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(item.name),
                          subtitle: Text(item.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('\$${item.price.toStringAsFixed(2)}'),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => ShopService.deleteMenuItem(
                                  shopId: shopId,
                                  menuItemId: item.id,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

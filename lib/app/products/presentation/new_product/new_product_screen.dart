import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/presentation/brands_screen.dart';
import 'package:payme/app/products/application/new_product_provider.dart';
import 'package:payme/app/products/presentation/new_product/widgets/product_text_field.dart';
import 'package:payme/app/units/presentation/unit_screen.dart';
import 'package:payme/core/extensions/route_extension.dart';
import 'package:payme/core/presentation/buttons/app_elevated_button.dart';
import 'package:payme/core/presentation/messages/messenger.dart';

class NewProductScreen extends ConsumerStatefulWidget {
  const NewProductScreen({super.key, this.brandUuid});

  final String? brandUuid;

  @override
  ConsumerState<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends ConsumerState<NewProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  bool _isLoading = false;
  String? _resultMessage;

  @override
  void initState() {
    _categoryController.text = widget.brandUuid ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _unitController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _selectUnit() async {
    context.push(
      UnitScreen(
        onUnitSelected: (unit) {
          setState(() {
            _unitController.text = unit.name;
          });
        },
      ),
    );
  }

  void _selectCategory() async {
    final selectedCategory = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => const BrandsScreen(brands: []),
    );
    if (selectedCategory != null) {
      setState(() {
        _categoryController.text = selectedCategory;
      });
    }
  }

  Future<void> _submitData() async {

    if (_nameController.text.length < 3) {
      setState(() {
        _resultMessage = "Наименование должно быть не менее 3 символов.";
      });
      return;
    } else if (_unitController.text.isEmpty) {
      setState(() {
        _resultMessage = "Не заполнена единица измерения.";
      });
      return;
    } else if (widget.brandUuid == null) {
      if (_categoryController.text.isEmpty) {
        setState(() {
          _resultMessage = "Не заполнена категория.";
        });
        return;
      }
    }

    final params = NewProductParams(
      name: _nameController.text,
      description: _descriptionController.text,
      brandUuid: _categoryController.text,
      unitName: _unitController.text,
    );

    final result1 = await ref.read(newProductProvider(params).future);
    if (result1 != null) {
      showSuccessMessage(context, 'Товар успешно добавлен');
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(true);
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Добавить новый товар',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white60,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProductTextField(
              controller: _categoryController,
              isVisible: widget.brandUuid == null,
              isEnabled: false,
              labelText: "Категория",
              suffixIcon: IconButton(
                icon: const Icon(Icons.category),
                onPressed: _selectCategory,
              ),
            ),

            ProductTextField(
              controller: _nameController,
              labelText: "Наименование",
            ),
            ProductTextField(
              controller: _descriptionController,
              labelText: "Описание",
            ),

            ProductTextField(
              controller: _unitController,
              labelText: "Единица измерения",
              suffixIcon: IconButton(
                icon: const Icon(Icons.list),
                onPressed: _selectUnit,
              ),
            ),

            const SizedBox(height: 16),
            AppElevatedButton(title: "Создать", onPressed: _submitData),

            const SizedBox(height: 16),
            if(_resultMessage != null)
              Text(
                _resultMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/utils/styles/color.dart';
import '../../data/product_model.dart';
import '../../services/cardService.dart';
import '../widget/product_command.dart';
import '../widget/product_counter.dart';

final cartService = CartService();

class AddProduct extends StatefulWidget {
  final ProductModel product;
  const AddProduct({super.key, required this.product});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  num currentNumber = 1;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: ProductCounter(
        currentNumber: currentNumber,
        onAdd: () => setState(() {
          currentNumber++;
        }),
        onRemove: () {
          if (currentNumber != 1) {
            setState(() {
              currentNumber--;
            });
          }
        }, product: widget.product
      ),
    );
  }
}

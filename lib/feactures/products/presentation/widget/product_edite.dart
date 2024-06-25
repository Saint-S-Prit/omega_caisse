import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/CustomSnackBar.dart';
import '../../../../core/common/widgets/input_custom.dart';
import '../../../../core/common/widgets/submit_button_custom.dart';
import '../../data/product_model.dart';
import '../bloc/product/update/product_update_bloc.dart';
import '../bloc/product/update/product_update_event.dart';
import '../bloc/product/update/product_update_state.dart';

class ProductEdite extends StatefulWidget {
  final ProductModel product;

  const ProductEdite({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductEdite> createState() => _ProductEditeState();
}

class _ProductEditeState extends State<ProductEdite> {

  late TextEditingController nameProductController = TextEditingController();
  late TextEditingController priceProductController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();





  late FocusNode _nameFocusNode;
  late FocusNode _priceFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String nameProductDefault = widget.product.name;
    int priceProductDefault = widget.product.price;

    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Padding(
      padding: mediaQueryData.viewInsets,
      child: SingleChildScrollView(
        child: BlocListener<ProductUpdateBloc, UpdateProductState>(
          listener: (context, state) async {
            if (state is UpdateProdLoaderState) {
              if (!state.response) {
                CustomSnackBar.show(context, 'Erreur mise à jour !', Colors.red);
              } else if (state.response) {
                CustomSnackBar.show(context, 'Valide mise à jour !', Colors.green);
                Navigator.of(context).pushNamed('/homeScreen');
              } else if (state is UpdateProdErrorState) {
                CustomSnackBar.show(context, 'Erreur interne,  Reesseyez', Colors.red);
              }
            }
          },

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputCustom(
                    keyboardType: TextInputType.text,
                    controller: TextEditingController(
                        text: widget.product.name),
                    labelText: "Nom du produit",
                    prefixIcon: Icons.production_quantity_limits_rounded,
                    hintText: "Nom du produit",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Le produit doit être requis";
                      }
                      nameProductDefault = value.toString();
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputCustom(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: widget.product.price.toString()),
                    labelText: "Prix du produit",
                    prefixIcon: Icons.attach_money_rounded,
                    hintText: "Prix du produit",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Le prix doit être requis";
                      }
                      // Vérifier si la valeur ne contient que des chiffres
                      final RegExp digitsOnly = RegExp(r'^[0-9]+$');
                      if (!digitsOnly.hasMatch(value)) {
                        return "Le prix doit être un nombre valide";
                      }
                      priceProductDefault = int.parse(value);
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),


                  BlocBuilder<ProductUpdateBloc, UpdateProductState>(
                    builder: (context, state) {
                      if (state is UpdateProdLoadingState) {
                        return SubmitButtonCustom(
                          onPressed: () {},
                          textSubmit: 'Loading...',
                          isLoading: true,
                        );
                      } else {
                        // Cas par défaut
                        return SubmitButtonCustom(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              String originalPath = widget.product.path;
                              String cleanedPath = originalPath.replaceAll("/storage/", "");
                              widget.product.path= cleanedPath;
                              widget.product.name = nameProductDefault;
                              widget.product.price = priceProductDefault;
                              context
                                  .read<ProductUpdateBloc>()
                                  .add(UpdateProdEvent(
                                productModel: widget.product,
                              ));

                              nameProductController.clear();
                              priceProductController.clear();
                            }
                          },
                          textSubmit: 'Editer',
                          isLoading: false,
                        );
                      }
                    },
                  )


                ],
              ),
            ),
          ),
          //),
        ),
      ),
    );
  }
}



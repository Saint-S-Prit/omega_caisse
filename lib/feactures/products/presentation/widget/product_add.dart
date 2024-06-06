import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/CustomSnackBar.dart';
import '../../../../core/common/widgets/input_custom.dart';
import '../../../../core/common/widgets/submit_button_custom.dart';
import '../../data/product_model.dart';
import '../bloc/product/update/product_update_bloc.dart';
import '../bloc/product/update/product_update_state.dart';
import '../screens/add_product.dart';

class ProductAdd extends StatefulWidget {
  final ProductModel product;

  const ProductAdd({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  late TextEditingController nameProductController = TextEditingController();
  late TextEditingController priceProductController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();

    nameProductController.clear();
    priceProductController.clear();

  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
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
            padding: const EdgeInsets.all(20.0),
            child: Form(

              key: formKey,
              child: Column(
                children: [
                  InputCustom(
                    keyboardType: TextInputType.text,
                    controller: nameProductController,
                    labelText: "Nom du produit",
                    prefixIcon: Icons.production_quantity_limits_rounded,
                    hintText: "Nom du produit",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Le produit doit être requis";
                      }
                      widget.product.name = value.toString();
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputCustom(
                    keyboardType: TextInputType.number,
                    controller: priceProductController,
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
                      widget.product.price = int.parse(value);
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  SubmitButtonCustom(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ProductModel product = ProductModel(
                          id: 0,
                          name: nameProductController.text,
                          price: int.parse(priceProductController.text),
                          path: "",
                          description: "",
                        );

                        // Réinitialiser les valeurs des champs de texte
                        nameProductController.clear();
                        priceProductController.clear();
                        Navigator.pop(context);

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true, // Permet au contenu de prendre autant de place que nécessaire
                          builder: (BuildContext context) {
                            return SizedBox( // Vous pouvez également utiliser un autre conteneur comme Scaffold si nécessaire
                              height: MediaQuery.of(context).size.height * 0.4, // Définir la hauteur souhaitée
                              child: AddProduct(
                                product: product,
                              ),
                            );
                          },
                        );
                        //product =;

                      }
                    },
                    textSubmit: 'Ajouter',
                    isLoading: false,
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

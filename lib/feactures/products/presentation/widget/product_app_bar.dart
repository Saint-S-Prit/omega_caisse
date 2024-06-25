import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_caisse/feactures/products/presentation/widget/product_command.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/styles/color.dart';
import '../bloc/cart/add_to_cart_bloc.dart';
import '../bloc/cart/add_to_cart_state.dart';


class ProductScreenAppbar extends StatelessWidget {
  const ProductScreenAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? isNotified = SharedPreferencesService.getIsNotified();

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Row(
          children: [
          Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/profileScreen");
              },
              child:  Icon(Icons.menu, color: appPrincipalColor, size: 30), // Use your appPrincipalColor here
            ),
            isNotified == "true" ?
            Positioned(
              right: -2, // Adjust the position as needed
              top: -2,   // Adjust the position as needed
              child: Container(
                width: 13, // Adjust the size as needed
                height: 13, // Adjust the size as needed
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ) : const SizedBox(),
          ],
        ),


            const Spacer(),
            Text(
              applicationName,
              style: TextStyle(
                fontSize: 24,
                color: appPrincipalColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),

            state.cartItems.isNotEmpty ?
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: state.cartItems.length > 3 ? MediaQuery.of(context).size.height * 0.7 : MediaQuery.of(context).size.height * 0.4,
                      child: const ProductCommand(),
                    );
                  },
                );
              },
              child: Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: appPrincipalColor,
                    ),
                    onPressed: null,
                  ),
                  Positioned(
                    right: 0,
                    top: -2,
                    child: Stack(
                      children: [
                        Icon(Icons.brightness_1, size: 27.0, color: appPrincipalColor),
                        Positioned(
                          top: 5.0,
                          right: 4.0,
                          child: Center(
                            child: Text(
                              Functions.totalProductInCart(state.cartItems),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                :
                const SizedBox()

          ],
        );
      },
    );
  }
}





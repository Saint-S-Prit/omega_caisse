import 'package:flutter/material.dart';
import '../../../../core/utils/styles/color.dart';
import '../widget/products_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: appWhiteColor,
      body: const ProductsScreen()
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/utils/styles/color.dart';
import '../widget/products_screen.dart';
import 'blocked_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {

    String? isSubscription = SharedPreferencesService.getIsSubscribed();

    return  Scaffold(
      backgroundColor: appWhiteColor,
      body:  isSubscription == "true" ?
      const ProductsScreen() :
      const BlockedScreen()
    );
  }
}

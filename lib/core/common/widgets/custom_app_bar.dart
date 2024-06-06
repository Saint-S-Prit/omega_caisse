import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color titleColor;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.titleColor = Colors.white, // Valeur par défaut pour titleColor
    this.onBackPressed, // Valeur par défaut pour onBackPressed
  }) : super(key: key);

  static const defaultTitleColor = Colors.white; // Définition de la valeur par défaut pour titleColor

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      elevation: 0,
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back, size: 25, color: Colors.white),
      //   onPressed: onBackPressed ?? () {
      //     Navigator.of(context).pop();
      //   },
      // ),
      title: SizedBox(
        height: 35.0,
        child: Text(
          title,
          style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

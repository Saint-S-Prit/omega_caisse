// import 'package:flutter/material.dart';
//
// class CustomSnackBar {
//   static void show(BuildContext context, String text, Color backgroundColor) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           child: Center(
//             child: Text(
//               text,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//         backgroundColor: backgroundColor,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
      BuildContext context,
      String text,
      Color backgroundColor,
      //Duration duration, // Ajoutez un paramètre de durée
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 1), // Définir la durée
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../../../../core/utils/styles/color.dart';
// import '../../../../core/utils/styles/typo.dart';
//
// class CustomModeCallWorker extends StatelessWidget {
//   final String mode;
//
//   const CustomModeCallWorker({Key? key, required this.mode}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       width: 110,
//       decoration: TextStyles.boxDecorationCustomer(context),
//       // decoration: BoxDecoration(
//       //   borderRadius: BorderRadius.circular(15),
//       //   //color: appPrincipalColor.withOpacity(.1),
//       //   color: appThirstColor.withOpacity(.1),
//       // ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           SizedBox(
//             height: 30,
//             width: 20,
//             child: mode == "appel"
//                 ? Image.asset(
//               "assets/calling.png",
//               width: 20,
//               height: 20,
//               color: appPrincipalColor,
//             )
//                 : Image.asset(
//               "assets/logo_whatsap.png",
//               width: 20,
//               height: 20,
//               color: appPrincipalColor,
//             ),
//           ),
//           mode == "appel" ? const Text("Appel") : const Text("Whatsapp"),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../../../../core/utils/styles/color.dart';
import '../../../../core/utils/styles/typo.dart';

class CustomModeCallWorker extends StatelessWidget {
  final String mode;

  const CustomModeCallWorker({Key? key, required this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 110,
      decoration: TextStyles.boxDecorationCustomer(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 30,
            width: 20,
            child: mode == "appel"
                ? Image.asset(
              "assets/calling.png",
              width: 20,
              height: 20,
              color: appPrincipalColor,
            )
                : mode == "whatsapp"
                ? Image.asset(
              "assets/logo_whatsap.png",
              width: 20,
              height: 20,
              color: appPrincipalColor,
            )
                : Image.asset(
              "assets/logo_gmail.png",
              width: 20,
              height: 20,
              color: appPrincipalColor,
            ),
          ),
          mode == "appel"
              ? const Text("Appel")
              : mode == "whatsapp"
              ? const Text("Whatsapp")
              : const Text("Gmail"),
        ],
      ),
    );
  }
}

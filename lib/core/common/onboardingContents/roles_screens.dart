import 'package:flutter/material.dart';

import '../../../core/common/widgets/submit_button_custom.dart';
import '../../../core/utils/styles/color.dart';

class RolesScreens extends StatefulWidget {
  const RolesScreens({Key? key}) : super(key: key);

  @override
  _RolesScreensState createState() => _RolesScreensState();
}

class _RolesScreensState extends State<RolesScreens> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Image.asset(
              'assets/logo.png', // Ajoutez le chemin de votre image
              height: 100,
              width: 100,
              fit: BoxFit.contain,
              //color: appPrincipalColor,
            ),
            const SizedBox(height: 40.0),
            const Text(
              'Door Waar est une application de mise en relation entre clients et prestataires de services.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 100.0),



            Wrap(
              children: [
                Text("En continuant, vous acceptez notre " ,style: TextStyle(fontSize: 12),),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/policeConfidentiality');
                  },
                  child: Text(
                    "politique de confidentialité",
                    style: TextStyle(color: appPrincipalColor, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                const Text(" et nos ",style: TextStyle(fontSize: 12),),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/termConditions');
                  },
                  child: Text(
                    "termes et conditions.",
                    style: TextStyle(color: appPrincipalColor, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),


            const SizedBox(height: 20.0),
            SubmitButtonCustom(
             onPressed: (){
               Navigator.of(context).pushNamed('/onboardingScreen');
             },
              textSubmit: 'Accepter',
            ),

          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class CallOption {
  // function whatsap
   whatsApp(String phoneNumber) {
     launchUrl(
      Uri.parse(
        'whatsapp://send?phone=$phoneNumber', //put your number here
      ),
    );
  }

  // function call
   makePhoneCall(String phoneNumber) async {
    if (await canLaunch('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
  // function url

   // Fonction pour ouvrir l'application Gmail avec un e-mail spécifique prérempli
   void openGmail(String email) async {
     final Uri _emailLaunchUri = Uri(
       scheme: 'mailto',
       path: email,
     );

     if (await canLaunch(_emailLaunchUri.toString())) {
       await launch(_emailLaunchUri.toString());
     } else {
       throw 'Could not launch Gmail';
     }
   }



  // Fonction pour ouvrir une URL spécifique
  // void openUrl(String url) async {
  //   if (!await launch(
  //     url,
  //     forceWebView: true,
  //     enableJavaScript: true,
  //   )) throw 'Could not launch $url';
  // }


   void openApp(String url) {
     launchUrl(
       Uri.parse(
         url, //put your number here
       ),
     );
   }
}







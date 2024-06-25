import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class CallOption {
  // function whatsap
  whatsAppOrCall(String phoneNumber) async {
    // Essayez d'ouvrir WhatsApp
    //bool openedWhatsApp = await whatsApp(phoneNumber);
    bool openedWhatsApp = await whatsApp(phoneNumber);
    // Si WhatsApp n'est pas ouvert, effectuez un appel téléphonique
    if (!openedWhatsApp) {
      await makePhoneCall(phoneNumber);
    }
  }

// Fonction pour ouvrir WhatsApp
  whatsApp(String phoneNumber) async {
    if (await launchUrl(
      Uri.parse(
        'whatsapp://send?phone=$phoneNumber',
      ),
    )) {
      return true;
    } else {
      return false;
    }
  }

// Fonction pour effectuer un appel téléphonique
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
  void openUrl(String url) async {
    if (!await launch(
      url,
      forceWebView: true,
      enableJavaScript: true,
    )) throw 'Could not launch $url';
  }


   void openApp(String url) async {
     try {
       bool launched = await launchUrl(
         Uri.parse(url),
       );
       if (!launched) {
         // Si l'application spécifique n'est pas lancée, ouvrir l'URL dans le navigateur
         openUrl(url);
       }
     } catch (e) {
       print('Erreur lors du lancement de l\'application : $e');
       // En cas d'erreur, ouvrir l'URL dans le navigateur
       openUrl(url);
     }
   }

   //
   // void openApp(String url) {
   //   launchUrl(
   //     Uri.parse(
   //       url, //put your number here
   //     ),
   //   );
   // }
}







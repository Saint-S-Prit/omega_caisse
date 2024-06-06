import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



const String termsAndConditions = """

  Inscription des Ouvriers : Préciser les exigences liées à l'inscription des ouvriers, y compris la vérification des informations et la période d'attente pour l'approbation.

  Données Personnelles : Clarifier comment les données personnelles, y compris les photos de CNI, seront utilisées et stockées, mettant l'accent sur la confidentialité et la sécurité.

  Système de Notation : Expliquer le fonctionnement du système de notation, y compris la possibilité pour les ouvriers de répondre aux évaluations et comment les commentaires seront modérés.

  Engagement de Service : Définir clairement les engagements des ouvriers envers les clients, y compris les détails des services fournis et les obligations financières. Traçabilité des Appels : Expliquer clairement que les appels effectués à travers l'application seront traçables et que les informations de communication, y compris les appels et les messages vocaux, seront enregistrées à des fins de sécurité et de résolution de litiges.

  Coordonnées des Prestataires : Indiquer que, dans le cas où une situation nécessite une intervention ou une résolution, les coordonnées du prestataire pourront être partagées avec le client, sous réserve d'une procédure appropriée et de la vérification de la légitimité de la demande.

  Utilisation des Informations : Clarifier que les informations de traçabilité ne seront utilisées que dans le cadre de la résolution de litiges ou de situations similaires et ne seront pas exploitées à d'autres fins.

  Confidentialité des Coordonnées : Assurer aux utilisateurs que leurs coordonnées personnelles ne seront pas partagées sans leur consentement, à l'exception des situations spécifiées dans les termes et conditions.

  Consentement de l'Utilisateur : Mettre en place un mécanisme de consentement explicite de la part des utilisateurs pour l'utilisation et le partage de ces informations de traçabilité dans des situations spécifiques.
  """;

class TermConditions extends StatelessWidget {
  const TermConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 25, color: Colors.white),
          onPressed: () {
            // Action du bouton de retour
            Navigator.of(context).pop();
          },
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 35.0,
              child: Text(
                "Termes et conditions",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date d\'entrée en vigueur : 12-03-2024',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20.0),
            Text(
              'Les présentes Conditions Générales d\'Utilisation (CGU) et Politique de Confidentialité régissent l\'utilisation de l\'application Door Waar. En utilisant cette application, vous acceptez les termes et conditions énoncés ci-dessous.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              '1. Utilisation de l\'Application',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '1.1 Vous devez être âgé d\'au moins 18 ans pour utiliser cette application.',
            ),
            Text(
              '1.2 Vous êtes responsable de maintenir la confidentialité de votre compte et de vos informations de connexion.',
            ),
            SizedBox(height: 20.0),
            Text(
              '2. Informations Collectées',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '2.1 Nous collectons des informations personnelles telles que décrites dans notre Politique de Confidentialité.',
            ),
            SizedBox(height: 20.0),
            Text(
              '3. Utilisation des Informations',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '3.1 Les informations collectées sont utilisées conformément à notre Politique de Confidentialité pour fournir et améliorer les services de l\'application.',
            ),
            SizedBox(height: 20.0),
            Text(
              '4. Propriété Intellectuelle',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '4.1 Tous les droits de propriété intellectuelle relatifs à l\'application et à son contenu appartiennent à Door Waar.',
            ),
            SizedBox(height: 20.0),
            Text(
              '5. Responsabilité',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '5.1 Door Waar n\'est pas responsable des dommages directs ou indirects découlant de l\'utilisation de l\'application.',
            ),
            SizedBox(height: 20.0),
            Text(
              '6. Modifications des Conditions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '6.1 Door Waar se réserve le droit de modifier les présentes conditions à tout moment. Les utilisateurs seront informés de toute modification via l\'application.',
            ),
            SizedBox(height: 20.0),
            Text(
              '7. Politique de Confidentialité',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '7.1 Les informations personnelles collectées sont soumises à notre Politique de Confidentialité.',
            ),
            SizedBox(height: 20.0),
            Text(
              '8. Signalements et Coopération en Cas d\'Incidents',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '8.1 En cas de comportement frauduleux ou d\'arnaque présumée de la part d\'un prestataire de services, les utilisateurs sont encouragés à signaler immédiatement l\'incident à Door Waar via l\'application ou par e-mail.',
            ),
            Text(
              '8.2 Door Waar se réserve le droit de coopérer avec les autorités compétentes et de fournir les informations nécessaires, y compris les coordonnées du prestataire et toute autre information pertinente, pour faciliter les enquêtes en cas d\'incident présumé de fraude ou d\'arnaque.',
            ),
            Text(
              '8.3 En signalant un incident, l\'utilisateur reconnaît et accepte que Door Waar puisse être amené à partager certaines informations avec les autorités compétentes dans le cadre de toute enquête ou procédure judiciaire.',
            ),
            SizedBox(height: 20.0),
            Text(
              '9. Contact',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Pour toute question concernant les CGU ou la Politique de Confidentialité, veuillez nous contacter à l\'adresse suivante : [adresse e-mail de contact].',
            ),
            SizedBox(height: 20.0),
            Text(
              'En utilisant l\'application Door Waar, vous acceptez les termes des présentes CGU et Politique de Confidentialité.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}


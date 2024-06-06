import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PoliceConfidentiality extends StatelessWidget {
  const PoliceConfidentiality({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
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
                  "Politique de confidentialité",
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
              'Door Waar s\'engage à protéger la confidentialité des utilisateurs de son application. Cette politique de confidentialité décrit les types d\'informations que nous collectons, comment nous les utilisons et les mesures que nous prenons pour protéger ces informations.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              '1. Informations Collectées',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              '1.1 Informations Personnelles',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Lors de l\'inscription en tant que prestataire ou client, nous collectons les informations suivantes :',
            ),
            Text(
              '- Pour les prestataires : photo de profil, prénom, région, département, numéro de téléphone, pièce d\'identité (recto uniquement), informations professionnelles telles que la profession, la description, les diplômes ou certifications (optionnelles).',
            ),
            Text(
              '- Pour les clients : prénom, région, département, numéro de téléphone.',
            ),
            SizedBox(height: 10.0),
            Text(
              '1.2 Informations d\'Utilisation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Nous collectons également des informations sur l\'utilisation de l\'application, telles que les interactions avec les prestataires, les recherches effectuées, les commentaires laissés et les favoris ajoutés.',
            ),
            SizedBox(height: 20.0),
            Text(
              '2. Utilisation des Informations',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Nous utilisons les informations collectées pour les finalités suivantes :',
            ),
            Text(
              '- Faciliter la mise en relation entre clients et prestataires.',
            ),
            Text(
              '- Améliorer et personnaliser l\'expérience utilisateur.',
            ),
            Text(
              '- Communiquer avec les utilisateurs concernant leur utilisation de l\'application.',
            ),
            Text(
              '- Assurer la sécurité et la protection des données des utilisateurs.',
            ),
            SizedBox(height: 20.0),
            Text(
              '3. Partage des Informations',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Nous ne partageons pas les informations personnelles des utilisateurs avec des tiers sans leur consentement, sauf dans les cas suivants :',
            ),
            Text(
              '- Lorsque cela est nécessaire pour fournir le service demandé par l\'utilisateur.',
            ),
            Text(
              '- Pour se conformer à la loi ou répondre à des demandes des autorités gouvernementales.',
            ),
            SizedBox(height: 20.0),
            Text(
              '4. Sécurité des Données',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Nous prenons des mesures de sécurité appropriées pour protéger les informations des utilisateurs contre tout accès non autorisé, altération, divulgation ou destruction.',
            ),
            SizedBox(height: 20.0),
            Text(
              '5. Modifications de la Politique de Confidentialité',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Nous nous réservons le droit de modifier cette politique de confidentialité à tout moment. Les utilisateurs seront informés de toute modification via l\'application.',
            ),
            SizedBox(height: 20.0),
            Text(
              '6. Contact',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Pour toute question concernant cette politique de confidentialité, veuillez nous contacter à l\'adresse suivante : [adresse e-mail de contact].',
            ),
            SizedBox(height: 20.0),
            Text(
              'En utilisant l\'application Door Waar, vous acceptez les termes de cette politique de confidentialité.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}












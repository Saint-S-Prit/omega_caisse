import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../feactures/Seller/presentation/screens/payment_screen.dart';
import '../../../feactures/authentication/presentation/bloc/logout/logout_bloc.dart';
import '../../../feactures/authentication/presentation/bloc/logout/logout_event.dart';
import '../../../feactures/authentication/presentation/bloc/logout/logout_state.dart';
import '../../../feactures/products/presentation/bloc/cart/add_to_cart_bloc.dart';
import '../../../feactures/products/presentation/bloc/cart/add_to_cart_state.dart';

import '../../utils/call_options.dart';
import 'separator.dart';
import '../../services/storage/SharedPreferencesService.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/styles/color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  String? id;
  String? token;
  String? fullName;
  String? phone;
  String? team;
  String? category;
  String? profile;
  String? isNotified;

  @override
  void initState() {
    super.initState();
    id =   SharedPreferencesService.getId();
    token =   SharedPreferencesService.getToken();
    fullName =   SharedPreferencesService.getFullName();
    phone =   SharedPreferencesService.getPhoneNumber();
    profile =   SharedPreferencesService.getProfile();
    team =   SharedPreferencesService.getTeam();
    category =   SharedPreferencesService.getCategory();
    isNotified = SharedPreferencesService.getIsNotified();

  }





  // Créez une instance de la classe CallOption
  CallOption callOption = CallOption();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: appPrincipalColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Panneau',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: appPrincipalColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: appPrincipalColor.withOpacity(0.2),
                        // red as border color
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Icon(
                      Icons.person,
                      color: appPrincipalColor,
                      size: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                        Text(
                          phone.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Separator(),
            profile == profileSeller ?
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pushNamed(
                        "/historiesSellerScreen",
                        arguments: {'id': int.parse(id.toString()), 'token': token},
                      );
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: appPrincipalColor.withOpacity(0.2),
                                  // red as border color
                                ),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Icon(
                                Icons.phone_iphone_sharp,
                                color: appPrincipalColor,
                              )),
                          trailing:  Icon(
                            Icons.arrow_forward_ios,
                            color: appPrincipalColor,
                          ),
                          title:  const Text(
                            "Historique",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ) :
            const SizedBox(),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed("/printParam");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: appPrincipalColor.withOpacity(0.2),
                              // red as border color
                            ),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Icon(
                            Icons.print,
                            color: appPrincipalColor,
                          )),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appPrincipalColor,
                      ),
                      title: const Text(
                        "Imprimente",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            profile == profileSeller && isNotified == "true" ?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child:

                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // Permet au contenu de prendre autant de place que nécessaire
                        builder: (_) {
                          return const SizedBox(
                              // Vous pouvez également utiliser un autre conteneur comme Scaffold si nécessaire
                              //height: MediaQuery.of(context).size.height *
                                  //0.3, // Définir la hauteur souhaitée
                              child: PaymentScreen());
                        },
                      );
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: appPrincipalColor.withOpacity(0.2),
                                  // red as border color
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Icon(
                                    Icons.attach_money_rounded,
                                    color: appPrincipalColor,
                                  ),
                                  isNotified == "true" ?
                                  Positioned(
                                    right: -13, // Adjust the position as needed
                                    top: -13,   // Adjust the position as needed
                                    child: Container(
                                      width: 13, // Adjust the size as needed
                                      height: 13, // Adjust the size as needed
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ) : const SizedBox(),
                                  ],
                                ),


                                ],
                              )),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: appPrincipalColor,
                          ),
                          title: const Text(
                            "Paiement",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ) : const SizedBox(),
            buildUserInfoDisplay(
                iconData: Icons.password,
                name: 'Modifier mon mot de passe',
                path: '/changePasswordScreen'),




          Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: GestureDetector(
        onTap: () async {
          //callOption.whatsApp(appPhoneNumber);
          callOption.whatsAppOrCall(appPhoneNumber);
        },
        child: Column(
          children: [
            ListTile(
              leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appPrincipalColor.withOpacity(0.2),
                      // red as border color
                    ),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(15)),
                  ),
                  child:  Icon(
                    Icons.phone_iphone_sharp,
                    color: appPrincipalColor,
                  )),
              trailing:  Icon(
                Icons.arrow_forward_ios,
                color: appPrincipalColor,
              ),
              title:  const Text(
                "Contactez un de nos agents",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),






            BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                return BlocBuilder<LogoutBloc, LogoutState>(
                  builder: (context, logoutState) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: GestureDetector(
                            onTap: () async {
                              context.read<LogoutBloc>().add(const LogoutSubmittedEvent());
                              await SharedPreferencesService.clearAllExceptFirstOpenAppStorage();
                              cartState.cartItems.clear();
                              Navigator.of(context).pushNamedAndRemoveUntil('/loginScreen', (Route<dynamic> route) => false);

                            },
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red.withOpacity(0.2),
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: const Icon(
                                      Icons.logout,
                                      color: Colors.red,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.red,
                                  ),
                                  title: const Text(
                                    "Déconnexion",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),


          ],
        ),
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(
          {required IconData iconData, required String name, String? path}) =>
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(path!);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              ListTile(
                  leading: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: appPrincipalColor.withOpacity(0.2),
                        // red as border color
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Icon(
                      iconData,
                      color: appPrincipalColor,
                      size: 30,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: appPrincipalColor,
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  )),
            ],
          ),
        ),
      );
}

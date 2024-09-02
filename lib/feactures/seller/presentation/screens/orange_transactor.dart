import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_caisse/feactures/seller/presentation/bloc/payment/payment_bloc.dart';
import 'package:omega_caisse/feactures/seller/presentation/bloc/payment/payment_state.dart';
import '../../../../core/common/widgets/input_custom.dart';
import '../../../../core/common/widgets/submit_button_custom.dart';
import '../../../../core/services/subscription/subscription_service.dart';
import '../../../../core/utils/styles/color.dart';
import '../../../products/presentation/screens/home_screen.dart';
import '../bloc/payment/payment_event.dart';

class OrangeTransactor extends StatefulWidget {
  const OrangeTransactor({Key? key}) : super(key: key);

  @override
  State<OrangeTransactor> createState() => _OrangeTransactorState();
}

class _OrangeTransactorState extends State<OrangeTransactor> {
  late TextEditingController phoneNumber = TextEditingController();
  late TextEditingController ussdCode = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    //final SubscriptionService subscriptionService = SubscriptionService();

    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: Padding(
        padding: mediaQueryData.viewInsets,
        child: SingleChildScrollView(
          child: BlocListener<PaymentBloc, PaymentState>(
            listener: (context, state) async {
              if (state is PaymentOrangeLoaderState) {
                //if (state.paymentResponse["success"] == true) {
                if (state.paymentResponse["test"] == true) {
                  showSuccessDialog(
                    context,
                    'Succès',
                    state.paymentResponse["message"].toString(),
                     //subscriptionService.login(context); // Remplacez par le widget de votre écran d'accueil
                  );
                } else {
                  showErrorDialog(
                    context,
                    'Erreur',
                    state.paymentResponse["message"].toString(),
                  );
                }
              } else if (state is PaymentErrorState) {
                showErrorDialog(
                  context,
                  'Erreur',
                  "Saisissez un numéro de téléphone valable et le montant !",
                   // Remplacez par le widget de votre écran d'accueil
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SizedBox(
                    //   child: Image.asset(
                    //     "assets/logo.png",
                    //     height: 200,
                    //     width: 200,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    InputCustom(
                      keyboardType: TextInputType.number,
                      controller: phoneNumber,
                      labelText: "Numéro de téléphone",
                      prefixIcon: Icons.phone,
                      hintText: "Entrez numéro de téléphone",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Le champ téléphone doit être requis";
                        }
                        final phoneRegExp = RegExp(r'^(7[05-8])[0-9]{7}$');
                        if (!phoneRegExp.hasMatch(value)) {
                          return "Numéro de téléphone invalide";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "Tapez #144#391*code_secret# pour obtenir un code de paiement!",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    InputCustom(
                      keyboardType: TextInputType.number,
                      controller: ussdCode,
                      labelText: "Code secret",
                      prefixIcon: Icons.code,
                      hintText: "ussd_code",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Le code usssd doit être requis";
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    const SizedBox(height: 20.0),
                    BlocBuilder<PaymentBloc, PaymentState>(
                      builder: (context, state) {
                        if (state is PaymentLoadingState) {
                          return SubmitButtonCustom(
                            onPressed: () {},
                            textSubmit: 'Loading...',
                            isLoading: true,
                          );
                        } else {
                          return SubmitButtonCustom(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<PaymentBloc>().add(
                                    PaymentOrangeSubmittedEvent(
                                      phone: phoneNumber.text,
                                      ussdCode: ussdCode.text,
                                    ));
                              }
                            },
                            textSubmit: 'Envoyer',
                            isLoading: false,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSuccessDialog(BuildContext context, String title, String description) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              //Navigator.of(context).pop(); // Fermer le popup
              SubscriptionService().login(context);
            },
          ),
        ],
      );
    },
  );
}

void showErrorDialog(BuildContext context, String title, String description) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Fermer le popup
            },
          ),
        ],
      );
    },
  );
}

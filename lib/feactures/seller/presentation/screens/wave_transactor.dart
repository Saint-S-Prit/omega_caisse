import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_caisse/feactures/seller/presentation/screens/wave_web_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/common/widgets/CustomSnackBar.dart';
import '../../../../core/common/widgets/input_custom.dart';
import '../../../../core/common/widgets/submit_button_custom.dart';
import '../../../../core/services/storage/local_storage_security.dart';
import '../../../../core/utils/call_options.dart';
import '../../../../core/utils/styles/color.dart';
import '../bloc/payment/payment_bloc.dart';
import '../bloc/payment/payment_event.dart';
import '../bloc/payment/payment_state.dart';


final localStorageSecurity = LocalStorageSecurity();


class WaveTransactor extends StatefulWidget {

  const WaveTransactor({Key? key}) : super(key: key);

  @override
  State<WaveTransactor> createState() => _WaveTransactorState();
}

class _WaveTransactorState extends State<WaveTransactor> {
  late TextEditingController phoneNumber = TextEditingController();

  late TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Créez une instance de la classe CallOption
  CallOption callOption = CallOption();



  
  @override
  Widget build(BuildContext context) {

    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: Padding(
        padding: mediaQueryData.viewInsets,
        child: SingleChildScrollView(
            child: BlocListener<PaymentBloc, PaymentState>(
              listener: (context, state) async {
                if (state is PaymentWaveLoaderState) {
                  if (state.paymentResponse.success) {
                    //print("GOOD");
                    //callOption.openApp(state.paymentResponse.data!.url.toString());
                    //callOption.openUrl(state.paymentResponse.data!.url.toString());
                    //openUrl(state.paymentResponse.data!.url.toString());
                    //const WhatsappWeb();
                    Navigator.of(context).pushNamed("/waveWebViewScreen", arguments: {"url": state.paymentResponse.data!.url.toString()});

                    // Fermer l'application après le lancement de l'URL
                    //SystemNavigator.pop();
                  } else {
                    CustomSnackBar.show(context, 'une erreur est survenue, veuillez réessayer !', Colors.red);
                  }
                } else if (state is PaymentErrorState) {
                  CustomSnackBar.show(context, 'Erreur interne, Reessayez', Colors.red);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InputCustom(
                        keyboardType: TextInputType.number,
                        controller: phoneNumber,
                        labelText: "Numéro de téléphone",
                        prefixIcon: Icons.phone,
                        hintText: "Enter numero telephone",
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
                                  print("Submit button pressed");
                                  context.read<PaymentBloc>().add(PaymentWaveSubmittedEvent(
                                    phone: phoneNumber.text,
                                  ));
                                }
                              },
                              textSubmit: 'Envoyer',
                              isLoading: false,
                            );
                          }
                        },
                      ),
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



Future<void> openUrl(String url) async {
  final _url = Uri.parse(url);
  if (!await launchUrl(_url, mode: LaunchMode.platformDefault)) { // <--
    throw Exception('Could not launch $_url');
  }
}




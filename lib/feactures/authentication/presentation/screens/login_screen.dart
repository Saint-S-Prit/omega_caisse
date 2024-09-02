import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_caisse/core/utils/functions.dart';
import '../../../../core/common/widgets/CustomSnackBar.dart';
import '../../../../core/common/widgets/call_options.dart';
import '../../../../core/common/widgets/input_custom.dart';
import '../../../../core/common/widgets/submit_button_custom.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/services/storage/local_storage_security.dart';
import '../../../../core/services/toggle_obscure_text/toggle_obscure_text_bloc.dart';
import '../../../../core/services/toggle_obscure_text/toggle_obscure_text_state.dart';
import '../../../../core/utils/call_options.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/validation.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';

final localStorageSecurity = LocalStorageSecurity();

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneNumber = TextEditingController();

  late TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  // Créez une instance de la classe CallOption
  CallOption callOption = CallOption();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoaderState) {
                if (state.status == "400" ) {
                  CustomSnackBar.show(context, 'Login ou mot de passe incorrect !', Colors.red);
                } else if (state.status == "200") {
                  if(SharedPreferencesService.getProfile() == profileSeller){
                    Navigator.of(context).pushNamed('/homeScreen');
                  }else if(SharedPreferencesService.getProfile() ==profileSupervisor){
                    Navigator.of(context).pushNamed('/adminScreen');
                  }else{
                    Navigator.of(context).pushNamed('/loginScreen');
                    CustomSnackBar.show(context, 'une erreur est survenue, veuillez reesseyer !', Colors.red);
                  }
                  //Navigator.of(context).pushNamed('/adminScreen');
                } else if (state.status == "500") {
                  CustomSnackBar.show(context, 'une erreur est survenue, veuillez reesseyer !', Colors.red);
                }
              } else if (state is LoginErrorState) {
                CustomSnackBar.show(context, 'Erreur interne,  Reesseyez', Colors.red);
              }
            },
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    child: Image.asset(
                      "assets/logo.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        BlocBuilder<ToggleObscureTextBloc, ToggleObscureTextState>(
                            builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputCustom(
                                keyboardType: TextInputType.number,
                                controller: password,
                                labelText: "Code secret",
                                prefixIcon: Icons.lock,
                              suffixIcon: Icons.lock,
                                //suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
                                hintText: "Password",
                                obscureText: (state as ToggleState).isObscure,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Le champ mot de passe doit être requis";
                                  }

                                  if (!Validation.digitsOnly.hasMatch(value)) {
                                    return "Le mot de passe doit contenir exactement 4 chiffres";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: GestureDetector(
                              onTap: () async {
                                callOption.whatsAppOrCall(appPhoneNumber);
                                //bool test = await callOption.whatsApp(appPhoneNumber);
                                // bool test = false;
                                // if (!test) {
                                //   callOption.makePhoneCall(appPhoneNumber);
                                // }
                              },
                            child: const Text(
                              "Mot de passe oublié",
                            )
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Column(
                          children: [
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state is LoginLoadingState) {
                                  return SubmitButtonCustom(
                                    onPressed: () {},
                                    textSubmit: 'Loading...',
                                    isLoading: true,
                                  );
                                } else {
                                  // Cas par défaut
                                  return SubmitButtonCustom(
                                    onPressed: () {
                                      //Navigator.of(context).pushNamed("/homeScreen");
                                      if (formKey.currentState!.validate()) {
                                        //print('${phoneNumber.text} ${password.text}');
                                        context
                                            .read<LoginBloc>()
                                            .add(LoginSubmittedEvent(
                                          phoneNumber: phoneNumber.text,
                                          password: password.text,
                                        ));
                                      }
                                    },
                                    textSubmit: 'Connexion',
                                    isLoading: false,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

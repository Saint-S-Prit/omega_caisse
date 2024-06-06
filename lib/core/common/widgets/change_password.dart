import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/validation.dart';
import 'SnackBarCustomer.dart';
import 'input_custom.dart';
import 'submit_button_custom.dart';
import '../../services/storage/SharedPreferencesService.dart';
import '../../services/storage/local_storage_security.dart';
import '../../services/toggle_obscure_text/toggle_obscure_text_bloc.dart';
import '../../services/toggle_obscure_text/toggle_obscure_text_event.dart';
import '../../services/toggle_obscure_text/toggle_obscure_text_state.dart';
import '../../utils/styles/color.dart';
import '../../../feactures/authentication/presentation/bloc/handle_password/handle_password_bloc.dart';
import '../../../feactures/authentication/presentation/bloc/handle_password/handle_password_event.dart';
import '../../../feactures/authentication/presentation/bloc/handle_password/handle_password_state.dart';
import '../../../feactures/authentication/presentation/bloc/register/register_state.dart';


class ChangePasswordScreen extends StatelessWidget {

  ChangePasswordScreen({super.key});

  late TextEditingController currentPassword = TextEditingController();
  late TextEditingController newPassword = TextEditingController();
  late TextEditingController confirmationPassword = TextEditingController();

  final formData = {};

  // VARIABLE POUR RECUPERER LES VALEURS SAISIES PAR LES UTILISATEURS
  final _formKey = GlobalKey<FormState>();

  var isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: appPrincipalColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            //Get.to(() => SwitchCustomOrWorker());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocListener<HandlePasswordBloc, HandlePasswordState>(
          listener: (context, state) async {
            if (state is HandlePasswordLoaderState) {
              if (state.message.contains("valide")) {
                await SharedPreferencesService.clearAllExceptFirstOpenAppStorage();
                const SnackBarCustomer(message: "Mot de passe changé avec succès",backgroundColor: Colors.green, textColor: Colors.white).showSnackBar(context);
                Navigator.of(context).pushNamed(
                    "/loginScreen");
              } else{
                SnackBarCustomer(message: state.message,backgroundColor: Colors.red, textColor: Colors.white).showSnackBar(context);

              }
            } else if (state is RegisterErrorState) {
              const SnackBarCustomer(message: "Une erreur interne, reesseyer",backgroundColor: Colors.red, textColor: Colors.white).showSnackBar(context);

            }
          },
          child: Form(
            // Étape 2 : Enveloppez vos champs dans un widget Form
            key: _formKey, // Attribuez la GlobalKey au formulaire
            child: Column(
              children: [
                SizedBox(
                  child: Image.asset(
                    "assets/logo.png",
                    height: 200,
                    width: 200,
                    color: appPrincipalColor,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: BlocBuilder<ToggleObscureTextBloc,
                        ToggleObscureTextState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            const Text(
                                "Modification mot de passe"),
                            const SizedBox(
                              height: 15.0,
                            ),
                            InputCustom(
                              keyboardType: TextInputType.number,
                              controller: currentPassword,
                              labelText: "Mot de passe actuel",
                              prefixIcon: Icons.lock,
                              suffixIcon: Icons.lock,
                              hintText: "Saisir votre mot de passe actuel",
                              obscureText: (state as ToggleState).isObscure,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Le champ mot de passe doit être requis";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            InputCustom(
                              keyboardType: TextInputType.number,
                              controller: newPassword,
                              labelText: "Nouveau mot de passe",
                              prefixIcon: Icons.lock,
                              hintText: "Saisir votre nouveau mot de password",
                              obscureText: (state).isObscure,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Le champ nouveau mot de passe doit être requis";
                                }

                                if (!Validation.digitsOnly.hasMatch(value)) {
                                  return "Le mot de passe doit contenir exactement 4 chiffres";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            InputCustom(
                              keyboardType: TextInputType.number,
                              controller: confirmationPassword,
                              labelText: "Confirmation du mot de passe",
                              prefixIcon: Icons.lock,
                              obscureText: (state).isObscure,
                              hintText: "Confirmez votre nouveau mot de passe",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Le champ confirmation doit être requis";
                                }
                                //final password = password.text;
                                if (value != newPassword.text) {
                                  return "Les mots de passe ne correspondent pas";
                                }

                                return null;
                              },
                            ),
                            // Row(
                            //   children: [
                            //     Switch(
                            //       onChanged: (value) {
                            //         context.read<ToggleObscureTextBloc>().add(
                            //             ToggleEvent()); // Inversez la valeur de obscureText
                            //       },
                            //       value: !(state)
                            //           .isObscure, // Inversez la valeur actuelle
                            //       activeTrackColor: appPrincipalColor,
                            //     ),
                            //     Text(
                            //       "Voir les mot de passe",
                            //       style: TextStyle(color: appPrincipalColor),
                            //     )
                            //   ],
                            // ),
                            const SizedBox(height: 20.0),

                            Column(
                              children: [
                                BlocBuilder<HandlePasswordBloc, HandlePasswordState>(
                                  builder: (context, state) {
                                    if (state is HandlePasswordLoadingState) {
                                      return SubmitButtonCustom(
                                        onPressed: () {},
                                        textSubmit: 'Loading...',
                                        isLoading: true,
                                      );
                                    } else if (state is HandlePasswordLoaderState ||
                                        state is HandlePasswordErrorState) {
                                      return Column(
                                        children: [
                                          SubmitButtonCustom(
                                            onPressed: () async {
                                              // localStorage.remove("phoneNumber");
                                              // localStorage.remove("password");

                                              if (_formKey.currentState!
                                                  .validate()) {
                                                //SharedPreferencesService.getPassword().toString() == newPassword.text.toString()

                                                print(SharedPreferencesService.getPassword().toString());
                                                print(currentPassword.text.toString());
                                                if(SharedPreferencesService.getPassword().toString() != currentPassword.text.toString()){

                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      backgroundColor: Colors.white,
                                                      content: Text(
                                                        "votre mot de passe est incorrecte",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold, color: Colors.red),
                                                      ),
                                                    ),
                                                  );

                                                  }else
                                                    {

                                                      final Map<String, dynamic> variableMap = {
                                                        "new_password": newPassword.text.toString(),
                                                        "confirm_password":newPassword.text.toString(),
                                                      };
                                                      print(variableMap.toString());
                                                      context
                                                          .read<HandlePasswordBloc>()
                                                          .add(HandlePasswordLoadedEvent(variableMap:variableMap));

                                                    }

                                              }
                                            },
                                            textSubmit: "Confirmer",
                                            isLoading: false,
                                          ),
                                          // Affichage du statut
                                        ],
                                      );
                                    } else {
                                      // Cas par défaut
                                      return  SubmitButtonCustom(
                                        onPressed: () async {
                                          // localStorage.remove("phoneNumber");
                                          // localStorage.remove("password");

                                          if (_formKey.currentState!
                                              .validate()) {
                                            //SharedPreferencesService.getPassword().toString() == newPassword.text.toString()

                                            print(SharedPreferencesService.getPassword().toString());
                                            print(currentPassword.text.toString());

                                            if(SharedPreferencesService.getPassword().toString() != currentPassword.text.toString()){

                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.white,
                                                  content: Text(
                                                    "votre mot de passe est incorrecte",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold, color: Colors.red),
                                                  ),
                                                ),
                                              );

                                            }else
                                            {

                                              final Map<String, dynamic> variableMap = {
                                                "new_password": newPassword.text.toString(),
                                                "confirm_password":newPassword.text.toString(),
                                              };
                                              print(variableMap.toString());
                                              context
                                                  .read<HandlePasswordBloc>()
                                                  .add(HandlePasswordLoadedEvent(variableMap:variableMap));

                                            }

                                          }
                                        },
                                        textSubmit: "Confirmer",
                                        isLoading: false,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                          ],
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

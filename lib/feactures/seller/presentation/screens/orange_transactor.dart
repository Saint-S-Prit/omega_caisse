import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/CustomSnackBar.dart';
import '../../../../core/common/widgets/input_custom.dart';
import '../../../../core/common/widgets/submit_button_custom.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/services/storage/local_storage_security.dart';
import '../../../../core/services/toggle_obscure_text/toggle_obscure_text_bloc.dart';
import '../../../../core/services/toggle_obscure_text/toggle_obscure_text_state.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/validation.dart';
import '../../../authentication/presentation/bloc/login/login_bloc.dart';
import '../../../authentication/presentation/bloc/login/login_event.dart';
import '../../../authentication/presentation/bloc/login/login_state.dart';


final localStorageSecurity = LocalStorageSecurity();

class OrangeTransactor extends StatefulWidget {
  const OrangeTransactor({Key? key}) : super(key: key);

  @override
  State<OrangeTransactor> createState() => _OrangeTransactorState();
}

class _OrangeTransactorState extends State<OrangeTransactor> {
  late TextEditingController phoneNumber = TextEditingController();
  late TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: SingleChildScrollView(
          //padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          //padding: mediaQueryData.viewInsets,
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoaderState) {
                if (state.status == "400") {
                  CustomSnackBar.show(context, 'Login ou mot de passe incorrect !', Colors.red);
                } else if (state.status == "200") {
                  if (SharedPreferencesService.getProfile() == profileSeller) {
                    Navigator.of(context).pushNamed('/homeScreen');
                  } else if (SharedPreferencesService.getProfile() == profileSupervisor) {
                    Navigator.of(context).pushNamed('/adminScreen');
                  } else {
                    Navigator.of(context).pushNamed('/loginScreen');
                    CustomSnackBar.show(context, 'une erreur est survenue, veuillez réessayer !', Colors.red);
                  }
                } else if (state.status == "500") {
                  CustomSnackBar.show(context, 'une erreur est survenue, veuillez réessayer !', Colors.red);
                }
              } else if (state is LoginErrorState) {
                CustomSnackBar.show(context, 'Erreur interne, Reessayez', Colors.red);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
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
                          BlocBuilder<ToggleObscureTextBloc, ToggleObscureTextState>(
                            builder: (context, state) {
                              return InputCustom(
                                keyboardType: TextInputType.number,
                                controller: password,
                                labelText: "Code secret",
                                prefixIcon: Icons.lock,
                                suffixIcon: Icons.lock,
                                hintText: "Mot de passe",
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
                              );
                            },
                          ),
                          const SizedBox(height: 20.0),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoadingState) {
                                return SubmitButtonCustom(
                                  onPressed: () {},
                                  textSubmit: 'Loading...',
                                  isLoading: true,
                                );
                              } else {
                                return SubmitButtonCustom(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(LoginSubmittedEvent(
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );

  }
}


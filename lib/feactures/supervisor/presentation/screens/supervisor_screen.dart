
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/common/widgets/input_custom.dart';
import '../../../../core/services/storage/SharedPreferencesService.dart';
import '../../../../core/utils/styles/color.dart';
import '../../../../core/utils/styles/typo.dart';
import '../../../../core/utils/validation.dart';
import '../../data/supervisor_model.dart';
import '../bloc/supervisor_bloc.dart';
import '../bloc/supervisor_event.dart';
import '../bloc/supervisor_state.dart';

class SupervisorScreen extends StatefulWidget {
  const SupervisorScreen({super.key});

  @override
  State<SupervisorScreen> createState() => _SupervisorScreenState();
}


class _SupervisorScreenState extends State<SupervisorScreen> {
  late TextEditingController searchController = TextEditingController();
  List<SupervisorModel> filteredSupervisorTeamLists = [];
  bool showBalance = false;


  String? token;
  String? fullName;
  String? phone;
  String? team;
  String? category;
  String? profile;

  @override
  void initState() {
    super.initState();
    token =   SharedPreferencesService.getToken();
    fullName =   SharedPreferencesService.getFullName();
    phone =   SharedPreferencesService.getPhoneNumber();
    profile =   SharedPreferencesService.getProfile();
    team =   SharedPreferencesService.getTeam();
    category =   SharedPreferencesService.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:  GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/profileScreen");
          },
          child: Icon(Icons.menu, color: appPrincipalColor,),
        ),
        title: Text(
          'Omega Caisse',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: appPrincipalColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SupervisorBloc>(
                create: (BuildContext context) => SupervisorBloc()
                  ..add(SupervisorGetTeamEvent())),

          ],
          child: BlocBuilder<SupervisorBloc, SupervisorState>(
            builder: (context, state) {
              if (state is SupervisorLoadingState) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: appPrincipalColor,
                    size: 14.0,
                  ),
                );
              }
              if (state is SupervisorErrorState) {
                return const Text("erreur");
              }
              if (state is SupervisorStateLoadedState) {
                List<SupervisorModel> supervisorList = state.supervisorTeamsList;

                //print(supervisorList[0].balance.toString());
                // Calculer la somme des soldes
                int totalBalance = calculateTotalBalance(supervisorList);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 10.0),
                        child:  Container(
                          decoration: TextStyles.customBoxDecoration(context),
                          width: double.infinity,
                          height: 100.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Votre solde",
                                    style: TextStyle(
                                        color: appPrincipalColor, fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ), Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        showBalance ? "${Validation.formatBalance(int.parse(totalBalance.toString()))} XOF" : "****",
                                        style: TextStyle(
                                          color: appPrincipalColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showBalance = !showBalance;
                                          });
                                        },
                                        child: Icon(
                                          showBalance
                                              ? Icons.remove_red_eye
                                              : Icons.remove_red_eye_outlined,
                                          color: appPrincipalColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                            itemCount: supervisorList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () async {
                                    Navigator.of(context).pushNamed(
                                      "/historiesSupervisorScreen",
                                      arguments: {'id': int.parse(supervisorList[index].id.toString()), 'token': token},
                                    );

                                  },
                                  child: buildTeamSupervisorDisplay(supervisorList[index]),
                              );
                            },
                          )
                      ),
                    ],
                  ),
                );
              }
              return Container(); // Handle other states or return a default widget
            },
          ),
        ),
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildTeamSupervisorDisplay(SupervisorModel supervisorModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: appPrincipalColor.withOpacity(0.2),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          supervisorModel.name.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        Text(supervisorModel.phone.toString())
                      ],
                    ),
                  ),
                  Text("${supervisorModel.balance} XOF", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // calculer la somme des soldes
  int calculateTotalBalance(List<SupervisorModel> supervisorList) {
    return supervisorList.fold(0, (sum, supervisor) => sum + supervisor.balance);
  }
}

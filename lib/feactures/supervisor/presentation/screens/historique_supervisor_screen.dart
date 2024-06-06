
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';


import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/selectWidget.dart';
import '../../../../core/utils/styles/color.dart';
import '../../../../core/utils/styles/typo.dart';
import '../../../../core/utils/validation.dart';
import '../../../seller/data/model/history_model.dart';
import '../../../seller/presentation/bloc/history/history_state.dart';
import '../bloc/supervisor_bloc.dart';
import '../bloc/supervisor_event.dart';
import '../bloc/supervisor_state.dart';
import '../widget/build_histories_display.dart';


class HistoriesSupervisorScreen extends StatefulWidget {
  final int idSeller;
  final String token;
  String? startDay;
  String? endDay;

  HistoriesSupervisorScreen(
      {super.key,
        required this.idSeller,
        required this.token,
        this.startDay,
        this.endDay});

  @override
  State<HistoriesSupervisorScreen> createState() =>
      _HistoriesSupervisorScreenState();
}

class _HistoriesSupervisorScreenState extends State<HistoriesSupervisorScreen> {
  late TextEditingController searchController = TextEditingController();
  bool showBalance = false;
  String selectedOption = "Jour";

  String showSelectedOptionName = "Aujourd'hui";
  DateTime customStartDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime customEndDate = DateTime.now();
  String? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Historiques',
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
                ..add(SupervisorGetHistoryTeamEvent(
                    id: widget.idSeller, token: widget.token, startDay: '', endDay: '')),
            ),
          ],
          child: BlocBuilder<SupervisorBloc, SupervisorState>(
            builder: (context, state) {
              if (state is SupervisorLoadingState) {
                return Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    color: appPrincipalColor,
                    size: 22.0,
                  ),
                );
              }
              if (state is HistoryErrorState) {
                return const Text("erreur");
              }
              if (state is SupervisorGetHistoryTeamState) {
                List<HistoryModel> supervisorGetHistoryTeamList =
                    state.supervisorGetHistoryTeamList;

                // Calculer la somme des soldes
                int totalBalance =
                Functions.calculateTotalBalance(supervisorGetHistoryTeamList);

                if (selectedOption == "Jour") {
                  selectedDateRange = "Aujourd'hui";
                  selectedDateRange = Functions.getTodayRange();
                } else if (selectedOption == "Semaine") {
                  selectedDateRange = Functions.getWeekRange();
                } else if (selectedOption == "Mois") {
                  selectedDateRange = Functions.getMonthRange();
                } else if (selectedOption == "Personnaliser") {
                  selectedDateRange = "Personnaliser";
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            Container(
                              decoration:
                              TextStyles.customBoxDecoration(context),
                              width: double.infinity,
                              height: 100.0,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Votre solde",
                                        style: TextStyle(
                                            color: appPrincipalColor,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            showBalance
                                                ? "${Validation.formatBalance(int.parse(totalBalance.toString()))} XOF"
                                                : "****",
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
                                                  : Icons
                                                  .remove_red_eye_outlined,
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
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SelectionWidget(
                                  isSelected: selectedOption == "Jour",
                                  name: "Jour",
                                  onTap: () {
                                    setState(() {
                                      showSelectedOptionName = "Aujourd'hui";
                                      selectedOption = "Jour";
                                      selectedDateRange =
                                          Functions.getTodayRange();
                                      widget.startDay = selectedDateRange;
                                      widget.endDay = DateTime.now().toString();
                                      updateHistoryList(context);
                                    });
                                  },
                                ),
                                SelectionWidget(
                                  isSelected: selectedOption == "Semaine",
                                  name: "Semaine",
                                  onTap: () {
                                    setState(() {
                                      selectedOption = "Semaine";
                                      selectedDateRange =
                                          Functions.getWeekRange();
                                      widget.startDay =
                                          selectedDateRange; // Mise à jour de startDay
                                      widget.endDay = DateTime.now()
                                          .toString(); // Mise à jour de endDay

                                      showSelectedOptionName =
                                      "${Functions.getWeekRangeWithoutHour()} - ${Functions.getTodayDateWithoutHour()}";
                                      updateHistoryList(context);
                                    });
                                  },
                                ),
                                SelectionWidget(
                                  isSelected: selectedOption == "Mois",
                                  name: "Mois",
                                  onTap: () {
                                    setState(() {
                                      showSelectedOptionName =
                                          Functions.getMonthRangeGetMonthName()
                                              .toString();
                                      selectedOption = "Mois";
                                      selectedDateRange =
                                          Functions.getMonthRange();
                                      widget.startDay =
                                          selectedDateRange; // Mise à jour de startDay
                                      widget.endDay = DateTime.now()
                                          .toString(); // Mise à jour de endDay
                                      updateHistoryList(
                                          context); // Appel de la mise à jour immédiatement
                                    });
                                  },
                                ),


                                SelectionWidget(
                                  isSelected: selectedOption == "Personnaliser",
                                  name: "Personnaliser",
                                  onTap: () {
                                    showHoloDatePicker(
                                      context,
                                      title: "Date de début",
                                      initialDateTime: customStartDate,
                                      minDate: DateTime(2023), // Start year must be 2023 or later
                                    ).then((pickedStartDate) {
                                      if (pickedStartDate != null) {
                                        showHoloDatePicker(
                                          context,
                                          title: "Date de fin",
                                          initialDateTime: customEndDate,
                                          minDate: pickedStartDate, // End date cannot be before start date
                                        ).then((pickedEndDate) {
                                          if (pickedEndDate != null) {
                                            setState(() {
                                              customStartDate = DateTime(
                                                pickedStartDate.year,
                                                pickedStartDate.month,
                                                pickedStartDate.day,
                                                0,
                                                0,
                                              );
                                              customEndDate = DateTime(
                                                pickedEndDate.year,
                                                pickedEndDate.month,
                                                pickedEndDate.day,
                                                23,
                                                59,
                                              );

                                              widget.startDay = "${customStartDate.year}-${customStartDate.month.toString().padLeft(2, '0')}-${customStartDate.day.toString().padLeft(2, '0')} 04:59:59";
                                              widget.endDay = "${customEndDate.year}-${customEndDate.month.toString().padLeft(2, '0')}-${customEndDate.day.toString().padLeft(2, '0')} 23:49:59";

                                              showSelectedOptionName = "${customStartDate.day.toString().padLeft(2, '0')}-${customStartDate.month.toString().padLeft(2, '0')}-${customStartDate.year}      au      ${customEndDate.day.toString().padLeft(2, '0')}-${customEndDate.month.toString().padLeft(2, '0')}-${customEndDate.year}";

                                              selectedOption = "Personnaliser";
                                              updateHistoryList(context); // Call updateHistoryList here
                                            });
                                          }
                                        });
                                      }
                                    });
                                  },



                                  //
                                  // {
                                  //   showHoloDatePicker(
                                  //     context,
                                  //     title: "Date de début",
                                  //     initialDateTime: customStartDate,
                                  //   ).then((pickedStartDate) {
                                  //     if (pickedStartDate != null) {
                                  //       showHoloDatePicker(
                                  //         context,
                                  //         title: "Date de fin", // Ajouter un titre pour la date de fin
                                  //         initialDateTime: customEndDate,
                                  //       ).then((pickedEndDate) {
                                  //         if (pickedEndDate != null) {
                                  //           setState(() {
                                  //             customStartDate = DateTime(
                                  //               pickedStartDate.year,
                                  //               pickedStartDate.month,
                                  //               pickedStartDate.day,
                                  //               0,
                                  //               0,
                                  //             );
                                  //             customEndDate = DateTime(
                                  //               pickedEndDate.year,
                                  //               pickedEndDate.month,
                                  //               pickedEndDate.day,
                                  //               23,
                                  //               59,
                                  //             );
                                  //
                                  //             widget.startDay = "${customStartDate.year}-${customStartDate.month.toString().padLeft(2, '0')}-${customStartDate.day.toString().padLeft(2, '0')} 04:59:59";
                                  //             widget.endDay = "${customEndDate.year}-${customEndDate.month.toString().padLeft(2, '0')}-${customEndDate.day.toString().padLeft(2, '0')} 23:49:59";
                                  //
                                  //             showSelectedOptionName = "${customStartDate.day.toString().padLeft(2, '0')}-${customStartDate.month.toString().padLeft(2, '0')}-${customStartDate.year} au ${customEndDate.day.toString().padLeft(2, '0')}-${customEndDate.month.toString().padLeft(2, '0')}-${customEndDate.year}";
                                  //
                                  //             selectedOption = "Personnaliser";
                                  //             //showSelectedOptionName = "Personnaliser";
                                  //             updateHistoryList(context); // Call updateHistoryList here
                                  //           });
                                  //         }
                                  //       });
                                  //     }
                                  //   });
                                  // },
                                ),

                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: appSecondaryColor,
                                ),
                                height: 50,
                                width: double.infinity,
                                child: Center(
                                    child: Text(
                                      showSelectedOptionName.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (supervisorGetHistoryTeamList.isNotEmpty)
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                  supervisorGetHistoryTeamList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        child: BuildHistoriesDisplay(orderList: supervisorGetHistoryTeamList[index],)
                                    );
                                  },
                                )
                              else
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Aucun historique',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Votre historique est vide pour le moment.',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Future<DateTime?> showHoloDatePicker(
      BuildContext context, {
        required String title,
        DateTime? initialDateTime,
        DateTime? minDate,
        DateTime? maxDate,
      }) async {
    DateTime selectedDate = initialDateTime ?? DateTime.now();

    return await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3, // 1/3 of the screen height
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 150,
                child: DatePickerWidget(
                  locale: DateTimePickerLocale.fr, // Set locale to French
                  initialDate: selectedDate,
                  firstDate: minDate ?? DateTime(2024),
                  lastDate: maxDate ?? DateTime(2101),
                  dateFormat: "dd-MMMM-yyyy",
                  pickerTheme: const DateTimePickerTheme(
                    itemTextStyle: TextStyle(color: Colors.black, fontSize: 18),
                    dividerColor: Colors.transparent,
                  ),
                  onChange: (DateTime newDate, _) {
                    selectedDate = newDate;
                  },
                ),
              ),
              TextButton(
                child: Container(
                  decoration: BoxDecoration(
                    color: appSecondaryColor, // Replace with appSecondaryColor
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child:  Text(
                    'Valide',
                    style: TextStyle(
                      color: appPrincipalColor, // Replace with appPrincipalColor
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(selectedDate);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<DateTime?> showCupertinoDatePicker(BuildContext context,
  //     {required String title,
  //       DateTime? initialDateTime,
  //       DateTime? minDate,
  //       DateTime? maxDate}) async {
  //   DateTime selectedDate = initialDateTime ?? DateTime.now();
  //
  //   return await showCupertinoModalPopup<DateTime>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         color: Colors.white,
  //         height: 300,
  //         child: Column(
  //           children: [
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 color: appPrincipalColor,
  //                 decoration: TextDecoration.none,
  //               ),
  //             ), // Afficher le titre
  //             SizedBox(
  //               height: 200,
  //               child: CupertinoDatePicker(
  //                 mode: CupertinoDatePickerMode.date,
  //                 initialDateTime: selectedDate,
  //                 minimumDate: minDate ?? DateTime(2000),
  //                 maximumDate: maxDate ?? DateTime(2101),
  //                 onDateTimeChanged: (DateTime newDateTime) {
  //                   selectedDate = newDateTime;
  //                 },
  //               ),
  //             ),
  //             CupertinoButton(
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: appSecondaryColor,
  //                   borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
  //                 ),
  //                 padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Adjust the padding as needed
  //                 child: Text(
  //                   'Valide',
  //                   style: TextStyle(
  //                     color: appPrincipalColor, // Ensures the text color is readable on a red background
  //                   ),
  //                 ),
  //               ),
  //               onPressed: () {
  //                 Navigator.of(context).pop(selectedDate);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }


  void updateHistoryList(BuildContext context) {
    BlocProvider.of<SupervisorBloc>(context).add(
      SupervisorGetHistoryTeamEvent(
        id: widget.idSeller,
        token: widget.token,
        startDay: widget.startDay,
        endDay: widget.endDay,
      ),
    );
  }
}

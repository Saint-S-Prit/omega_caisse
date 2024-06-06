import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omega_caisse/core/common/widgets/no_service_found.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/common/widgets/input_custom.dart';
import '../../../../core/utils/styles/color.dart';
import '../../../../core/utils/styles/typo.dart';
import '../../../../core/utils/validation.dart';
import '../../data/model/history_model.dart';
import '../bloc/history/history_bloc.dart';
import '../bloc/history/history_event.dart';
import '../bloc/history/history_state.dart';

class HistoriesSellerScreen extends StatefulWidget {
  final int idSeller;
  final String token;
  const HistoriesSellerScreen({super.key, required this.idSeller, required this.token});

  @override
  State<HistoriesSellerScreen> createState() => _HistoriesSellerScreenState();
}

class _HistoriesSellerScreenState extends State<HistoriesSellerScreen> {

  late TextEditingController search = TextEditingController();


  @override
  void initState() {
    super.initState();
  }


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
            BlocProvider<HistoryBloc>(
                create: (BuildContext context) => HistoryBloc()
                  ..add(HistoryLoadedEvent(id: widget.idSeller, token: widget.token))),

          ],
          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoadingState) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: appPrincipalColor,
                    size: 14.0,
                  ),
                );
              }
              if (state is HistoryErrorState) {
                return const Text("erreur");
              }
              if (state is HistoryLoadedState) {
                List<HistoryModel> orderList = state.orderList;
                return  state.orderList.isNotEmpty ?
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 50,
                          width: double.infinity,
                          decoration: TextStyles.customBoxDecoration(context),
                          child: InputCustom(
                            controller: search,
                            labelText: "Recherche",
                            prefixIcon: Icons.search,
                            hintText: "Recherche",
                            obscureText: false,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                            itemCount: orderList.length,
                            itemBuilder: (context, index) {
                              return buildHistoriesDisplay(orderList[index]);
                            },
                          )
                      ),
                    ],
                  ),
                ) :
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
  Widget buildHistoriesDisplay(HistoryModel orderList) =>
      //Widget buildUserInfoDisplay({required IconData iconData, required String name,}) =>
  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                 orderList.name.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),),
              Text(
                //"${orderList.amount.toString()} XOF",
                "${Validation.formatBalance(orderList.amount)} XOF",
                style: const TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(orderList.datetime),
              Text(
                "Succes",
                style: TextStyle(color: appPrincipalColor),
              )
            ],
          ),
          Divider(
            color: appPrincipalColor.withOpacity(0.2),
            thickness: 1,
          )
        ],
      ));
}



void sharePressed() {
  String message = 'Check out eclectify University, where you can become an '
      'Elite Flutter Developer in no time: https://eclectify-universtiy.web.app';
  Share.share(message);

  /// optional subject that will be used when sharing to email
  // Share.share(message, subject: 'Become An Elite Flutter Developer');

  /// share a file
  // Share.shareFiles(['${directory.path}/image.jpg'], text: 'Great picture');
  /// share multiple files
  // Share.shareFiles(['${directory.path}/image1.jpg', '${directory.path}/image2.jpg']);
}

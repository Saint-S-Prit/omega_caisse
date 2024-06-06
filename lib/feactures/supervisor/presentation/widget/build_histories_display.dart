
import 'package:flutter/material.dart';

import '../../../../core/utils/styles/color.dart';
import '../../../../core/utils/validation.dart';
import '../../../seller/data/model/history_model.dart';


class BuildHistoriesDisplay extends StatelessWidget {
  final HistoryModel orderList;

  // Constructor to initialize orderList and appPrincipalColor
  const BuildHistoriesDisplay({Key? key, required this.orderList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderList.name.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${Validation.formatBalance(orderList.amount)} XOF",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
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
      ),
    );
  }
}

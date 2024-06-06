import 'package:flutter/material.dart';
import 'package:omega_caisse/core/utils/styles/color.dart';

class SelectionWidget extends StatelessWidget {
  final bool isSelected;
  final String name;
  final VoidCallback onTap;

  const SelectionWidget({
    Key? key,
    required this.isSelected,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Container(
          width: 80,
          decoration: BoxDecoration(
            color: isSelected ? appSecondaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                name,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class NoSwipeBack extends StatelessWidget {
  final Widget child;

  const NoSwipeBack({required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Empêche le glissement de retour (swipe back)
        return false;
      },
      child: child,
    );
  }
}

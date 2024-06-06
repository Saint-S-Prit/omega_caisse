import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/utils/styles/color.dart';


class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  late AnimationController animationController;
  late Animation<double> animation;
  //LocationService _locationService = LocationService(); // Créez une instance de LocationService

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () async {
      // Appelez la méthode _getLocation() ici
      //await _getLocation();
      navigationPage();
    });
  }

  void navigationPage() {
    Navigator.of(context).pushNamed('/loginScreen');
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  appPrincipalColor,
                  Colors.white70
                ], // You can adjust the colors as needed
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Image.asset(
                  'assets/logo.png',
                  //color: appWhiteColor,
                  height: 70.0,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: animation.value * 250,
                height: animation.value * 250,
                //color: appWhiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int durationInMinutes;

  const CountdownTimer({Key? key, required this.durationInMinutes}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    int totalSeconds = widget.durationInMinutes * 60;
    _secondsRemaining = totalSeconds;

    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(Duration(seconds: _secondsRemaining)),
      style: const TextStyle(fontSize: 24),
    );
  }
}

// Utilisation de CountdownTimer :
// Appelez cette fonction avec la durée en minutes que vous souhaitez pour le compte à rebours
// par exemple, CountdownTimer(durationInMinutes: 3)

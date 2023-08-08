import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  final DateTime startTime;
  final DateTime endTime;
  final bool isRunning;
  final bool isUpcoming;

  CountdownTimer(
      {required this.startTime,
      required this.endTime,
      required this.isRunning,
      required this.isUpcoming});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  Duration _remainingDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingDuration = widget.startTime.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingDuration = widget.endTime.isAfter(DateTime.now())
            ? widget.endTime.difference(DateTime.now())
            : Duration.zero;
      });
    });
  }

  String _formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color timerColor =
        _remainingDuration.inMinutes < 5 ? Colors.red : Colors.green;

    return Row(
      children: [
        Icon(Icons.timer, color: timerColor),
        const SizedBox(width: 5),
        Text(
          'Time ${widget.isRunning ? "Left" : "Start"}: ${_formatDuration(_remainingDuration)}',
          style: TextStyle(color: widget.isRunning ? Colors.red : Colors.green),
        ),
      ],
    );
  }
}

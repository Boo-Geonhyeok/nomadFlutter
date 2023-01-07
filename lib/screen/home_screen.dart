import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int twentyFiveMin = twentyFiveMinutes;
  int totalPomo = 0;
  bool isRunning = false;
  late Timer timer;

  void onTick(Timer timer) {
    setState(() {
      twentyFiveMin--;
      if (twentyFiveMin == 0) {
        totalPomo++;
        twentyFiveMin = twentyFiveMinutes;
        timer.cancel();
        isRunning = false;
      }
    });
  }

  String formatDate(int seconds) {
    var duration =
        Duration(seconds: seconds).toString().split(".")[0].substring(2, 7);
    return duration;
  }

  void onStartPressed() {
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
  }

  void onPausePressed() {
    setState(() {
      isRunning = false;
    });
    timer.cancel();
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      twentyFiveMin = twentyFiveMinutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                formatDate(twentyFiveMin),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 120,
                        color: Theme.of(context).cardColor,
                        onPressed: isRunning ? onPausePressed : onStartPressed,
                        icon: Icon(isRunning
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      IconButton(
                          iconSize: 40,
                          onPressed: onResetPressed,
                          icon: Icon(
                            Icons.restart_alt_outlined,
                            color: Theme.of(context).cardColor,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "POMODOROS",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        Text(
                          "$totalPomo",
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

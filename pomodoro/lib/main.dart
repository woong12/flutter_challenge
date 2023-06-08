import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const PomoTimer());
}

class PomoTimer extends StatefulWidget {
  const PomoTimer({Key? key}) : super(key: key);

  static const timesetList = [
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    55,
    60,
  ];

  @override
  State<PomoTimer> createState() => _PomoTimerState();
}

class _PomoTimerState extends State<PomoTimer> {
  int selectedButtonIndex = -1;
  int _selectedTime = 10;
  int _totalSec = 10 * 60;
  int _countRound = 0;
  int _countGoal = 0;
  bool _isPlay = false;
  bool _isPause = false;
  int _totalBreakSec = 5 * 60;

  late Timer _timer;
  late Timer _breakTimer;

  void _timerStart() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 30),
      _handleTick,
    );
    _isPlay = true;
    setState(() {});
  }

  void _timerPause() {
    _timer.cancel();
    _isPlay = false;
    setState(() {});
  }

  void _resetTimer() {
    _totalSec = _selectedTime * 60;
    _timerPause();
    setState(() {});
  }

  void _handleTimeSet(int timeset) {
    if (_isPlay || _isPause) return;
    _selectedTime = timeset;
    _totalSec = timeset * 60;
    setState(() {});
  }

  void _handleTick(Timer timer) {
    if (_totalSec == 0) {
      _isPlay = false;
      _totalSec = _selectedTime * 60;
      if (_countRound == 4) {
        _countRound = 1;
        _countGoal++;
      } else {
        _countRound++;
      }
      _startBreakTime();
      timer.cancel();
    } else {
      _totalSec--;
    }
    setState(() {});
  }

  void _handleBreakTick(Timer timer) {
    if (_totalBreakSec == 0) {
      _isPause = false;
      _totalBreakSec = 5 * 60;
      _breakTimer.cancel();
    } else {
      _totalBreakSec--;
    }
    setState(() {});
  }

  void _startBreakTime() {
    _isPause = true;
    _breakTimer = Timer.periodic(
      const Duration(milliseconds: 30),
      _handleBreakTick,
    );
  }

  String getRemainedMinutes(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 4);
  }

  String getRemainedSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(5);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                45,
              ),
              color: const Color.fromARGB(255, 244, 71, 68),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 35,
                    right: 35,
                    top: 60,
                    bottom: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isPause ? 'Break Time!' : 'POMOTIMER',
                        style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 22,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),

                // Time Counter

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          const TimeContainer(
                              bottom: 32, width: 130, height: 170),
                          const TimeContainer(
                              bottom: 16, width: 140, height: 180),
                          Positioned(
                            child: Container(
                              width: 150,
                              height: 190,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  getRemainedMinutes(
                                    _isPause ? _totalBreakSec : _totalSec,
                                  ),
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 244, 71, 68),
                                    decoration: TextDecoration.none,
                                    fontSize: 80,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Column(
                        children: [
                          Dot(),
                          SizedBox(
                            height: 15,
                          ),
                          Dot(),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          const TimeContainer(
                              bottom: 32, width: 130, height: 170),
                          const TimeContainer(
                              bottom: 16, width: 140, height: 180),
                          Positioned(
                            child: Container(
                              width: 150,
                              height: 190,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  getRemainedSeconds(
                                    _isPause ? _totalBreakSec : _totalSec,
                                  ),
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 244, 71, 68),
                                    decoration: TextDecoration.none,
                                    fontSize: 80,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),

                // Select Time

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var timeset in PomoTimer.timesetList) ...[
                            Opacity(
                              opacity: _isPlay || _isPause ? 0.3 : 1,
                              child: GestureDetector(
                                onTap: () => _handleTimeSet(timeset),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: timeset == _selectedTime
                                          ? const Color.fromARGB(
                                              255, 244, 71, 68)
                                          : Colors.white,
                                      width: 3,
                                    ),
                                    color: timeset == _selectedTime
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 244, 71, 68),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$timeset',
                                      style: TextStyle(
                                        color: timeset == _selectedTime
                                            ? const Color.fromARGB(
                                                255, 244, 71, 68)
                                            : Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 23,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (timeset != PomoTimer.timesetList.last)
                              const SizedBox(
                                width: 12,
                              ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                // Pause and Reset Button

                Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _isPause || _isPlay
                            ? () => _timerPause()
                            : () => _timerStart(),
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(45, 0, 0, 0),
                          ),
                          child: Icon(
                            _isPlay ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _resetTimer,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color.fromARGB(45, 0, 0, 0),
                          ),
                          child: const Icon(
                            Icons.restart_alt_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),

                // Count Row

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$_countRound/4',
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white54,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 13),
                        const Text(
                          "ROUND",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 120),
                    Column(
                      children: [
                        Text(
                          '$_countGoal/12',
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white54,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 13),
                        const Text(
                          "GOAL",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class TimeContainer extends StatelessWidget {
  final double bottom;
  final double width;
  final double height;

  const TimeContainer({
    super.key,
    required this.bottom,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

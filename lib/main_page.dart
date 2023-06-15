import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xvpn/pulsating_button.dart';
import 'package:xvpn/snapping_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, selectedColor}) : super(key: key);
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int counter = 0;
  Color selectedColor = const Color(0xff910000);
  Duration duration = const Duration();
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildBackGround(),
            _buildAppbar(),
            SnappingList(
              selectedColor: selectedColor,
            ),
            _buildTimer(),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackGround() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          color: const Color(0xff1C1C1C),
          width: double.infinity,
          height: 500,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 110),
          child: Image.asset(
            'assets/bg.png',
            color: const Color(0xff2F2F2F),
          ),
        ),
      ),
    ]);
  }

  Widget _buildAppbar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xff2F2F2F),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Image.asset(
                'assets/dots.png',
                height: 20,
                color: const Color(0xffCCCF00),
              ),
            ),
          ),
          const Spacer(),
          Image.asset(
            'assets/vpn.png',
            width: 70,
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xffCCCF00),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Image.asset('assets/crown.png',
                  height: 25, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            color: selectedColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 40),
              PulsatingButton(
                selectedColor: selectedColor,
                counter: counter,
                onPressed: () {
                  colorSwitch();
                },
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      width: 165,
                      height: 50,
                      child: Row(
                        children: [
                          const Spacer(),
                          Image.asset(
                            'assets/uparrow.png',
                            color: (counter == 1 ? Colors.black : Colors.white),
                            width: 15,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            '0.00 MB/s',
                            style: TextStyle(
                                color: (counter == 1
                                    ? Colors.black
                                    : Colors.white),
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      width: 165,
                      height: 50,
                      child: Row(
                        children: [
                          const Spacer(),
                          Image.asset(
                            'assets/downarrow.png',
                            color: (counter == 1 ? Colors.black : Colors.white),
                            width: 15,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            '0.00 MB/s',
                            style: TextStyle(
                                color: (counter == 1
                                    ? Colors.black
                                    : Colors.white),
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimer() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = twoDigits(duration.inHours);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 300),
        child: Text(
          '$hours:$minutes:$seconds',
          style: TextStyle(
              fontSize: 50, color: selectedColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void colorSwitch() {
    switch (counter) {
      case 0:
        setState(() {
          selectedColor = const Color(0xffCCCF00);
          counter += 1;
        });
        break;
      case 1:
        setState(() {
          startTimer();
          selectedColor = const Color(0xff00DC7B);
          counter += 1;
        });
        break;
      case 2:
        setState(() {
          stopTimer();
          selectedColor = const Color(0xff910000);
          counter = 0;
        });
        break;
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void stopTimer() {
    setState(() => duration = const Duration());
    setState(() => timer?.cancel());
  }
}

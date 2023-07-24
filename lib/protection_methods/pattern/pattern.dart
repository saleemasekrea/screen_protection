import 'package:flutter/material.dart';
import 'package:screen_protection/protection_methods/pattern/functions.dart';
import 'package:screen_protection/protection_methods/pattern/pattern_container.dart';

import '../../data/data.dart';

class Pattern extends StatefulWidget {
  final List<int> state;
  final int dimension;
  final Widget child;
  final Color? patternBackgroundColor;
  const Pattern(
      {super.key,
      required this.state,
      required this.child,
      required this.dimension,
      this.patternBackgroundColor});

  @override
  State<Pattern> createState() => _PatternState(
        state: state,
        child: child,
        dimension: dimension,
        patternBackgroundColor: patternBackgroundColor,
      );
}

class _PatternState extends State<Pattern> {
  final List<int> state;
  final int dimension;
  final Widget child;
  final List<int> pattern = [];
  final Color? patternBackgroundColor;
  _PatternState(
      {required this.state,
      required this.child,
      required this.dimension,
      this.patternBackgroundColor});

  Offset offset = const Offset(0, 0);
  List<int> dots = [];

  bool isMatch(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //the screen width
    double screenWidth = MediaQuery.of(context).size.width;
    //describtion of the screen
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: patternBackgroundColor ?? Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //desc of screen
              Text(
                state.first == 1 ? 'Set your pattern' : 'Draw your pattern',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              PatternContainer(
                dots: dots,
                dimension: dimension,
                offset: offset,
                sideLength: screenWidth,
                margin: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      clearDots(offset: offset, dots: dots);
                      setState(() {});
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (state.first == 1) {
                        Data.myData.put('secured', 1);
                        Data.myData.put('pattern', dots);
                        Data.myData.put('dim', dimension);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pattern(
                                state: const [2],
                                dimension: dimension,
                                child: child,
                              ),
                            ),
                            (Route<dynamic> route) => false);
                      } else {
                        if (isMatch(dots, Data.myData.get('pattern'))) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => child,
                              ),
                              (Route<dynamic> route) => false);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content:
                                    const Text('Pattern entered incorrectly.'),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

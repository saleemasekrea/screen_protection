import 'package:flutter/material.dart';
import 'package:screen_protection/data/data.dart';
import 'package:screen_protection/functions/set_method.dart';
import 'package:screen_protection/protection_methods/fingerprint/fprint.dart';
import 'package:screen_protection/protection_methods/pattern/pattern.dart';
import 'package:screen_protection/protection_methods/pin/pin.dart';

class Protector extends StatelessWidget {
  final Widget child;
  const Protector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Data.myData.get('secured') == null
          ? StartingPoint(
              child: child,
            )
          : callMethod(child),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartingPoint extends StatefulWidget {
  final Widget child;
  const StartingPoint({super.key, required this.child});

  @override
  State<StartingPoint> createState() => _StartingPointState(
        child: child,
      );
}

class _StartingPointState extends State<StartingPoint> {
  Widget child;
  _StartingPointState({required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Choose your security method',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PinCodeScreen(
                        isFirsttime: true,
                        pinText: 'Create your PIN',
                        child: child,
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 4,
                      color: Colors.amber,
                    ),
                  ),
                  width: 200,
                  height: 80,
                  child: const Text(
                    'PIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pattern(
                        state: const [1],
                        dimension: 3,
                        child: child,
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 4,
                      color: Colors.amber,
                    ),
                  ),
                  width: 200,
                  height: 80,
                  child: const Text(
                    'Pattern',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FingerPrint(
                        child: child,
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 4,
                      color: Colors.amber,
                    ),
                  ),
                  width: 200,
                  height: 80,
                  child: const Text(
                    'Fingerprint',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

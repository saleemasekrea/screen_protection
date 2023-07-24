import 'package:flutter/material.dart';
import 'package:screen_protection/data/data.dart';
import 'package:screen_protection/functions/set_method.dart';
import 'package:screen_protection/protection_methods/fingerprint/fprint.dart';
import 'package:screen_protection/protection_methods/pattern/pattern.dart';
import 'package:screen_protection/protection_methods/pin/pin.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  //clear the cach at each run for testing
  Data.myData.put('secured', null);
  runApp(
    Protector(
      realApp: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text('yoooo'),
          ),
        ),
      ),
    ),
  );
}

class Protector extends StatelessWidget {
  final Widget realApp;
  final bool pin;
  final bool pattern;
  final bool fingerprint;
  final Text mainTitle;
  final Color backgroundColor;
  final AppBar? appBar;
  final Widget? mainButtonStyle;
  final Color pinBackgroundColor;
  final Color patternBackgroundColor;
  final Color fingerprintBackgroundColor;
  final int patternDimension;
  Protector({
    super.key,
    required this.realApp,
    this.fingerprint = true,
    this.pattern = true,
    this.pin = true,
    this.appBar,
    this.backgroundColor = Colors.black,
    this.mainTitle = const Text(
      'Choose your security method',
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),
    ),
    this.mainButtonStyle,
    this.fingerprintBackgroundColor = Colors.black,
    this.patternBackgroundColor = Colors.black,
    this.pinBackgroundColor = Colors.black,
    this.patternDimension = 3,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Data.myData.get('secured') == null
          ? StartingPoint(
              backgroundColor: backgroundColor,
              appBar: appBar,
              fingerprint: fingerprint,
              mainTitle: mainTitle,
              pattern: pattern,
              pin: pin,
              mainButtonStyle: mainButtonStyle,
              fingerprintBackgroundColor: fingerprintBackgroundColor,
              patternBackgroundColor: pinBackgroundColor,
              pinBackgroundColor: pinBackgroundColor,
              patternDimension: patternDimension,
              child: realApp,
            )
          : callMethod(realApp),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartingPoint extends StatefulWidget {
  final Widget child;
  final bool pin;
  final bool pattern;
  final bool fingerprint;
  final Text mainTitle;
  final Color backgroundColor;
  final AppBar? appBar;
  final Widget? mainButtonStyle;
  final Color pinBackgroundColor;
  final Color patternBackgroundColor;
  final Color fingerprintBackgroundColor;
  final int patternDimension;
  StartingPoint({
    super.key,
    required this.child,
    this.fingerprint = true,
    this.pattern = true,
    this.pin = true,
    this.appBar,
    this.backgroundColor = Colors.black,
    this.mainTitle = const Text(
      'Choose your security method',
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),
    ),
    this.mainButtonStyle,
    this.fingerprintBackgroundColor = Colors.black,
    this.patternBackgroundColor = Colors.black,
    this.pinBackgroundColor = Colors.black,
    this.patternDimension = 3,
  });

  @override
  State<StartingPoint> createState() => _StartingPointState(
        child: child,
        backgroundColor: backgroundColor,
        favAppBar: appBar,
        fingerprint: fingerprint,
        mainTitle: mainTitle,
        pattern: pattern,
        pin: pin,
        mainButtonStyle: mainButtonStyle,
        fingerprintBackgroundColor: fingerprintBackgroundColor,
        patternBackgroundColor: pinBackgroundColor,
        pinBackgroundColor: pinBackgroundColor,
        patternDimension: patternDimension,
      );
}

class _StartingPointState extends State<StartingPoint> {
  Widget child;
  bool pin;
  bool pattern;
  bool fingerprint;
  Text mainTitle;
  Color backgroundColor;
  AppBar? favAppBar;
  Widget? mainButtonStyle;
  Color pinBackgroundColor;
  Color patternBackgroundColor;
  Color fingerprintBackgroundColor;
  int patternDimension;
  _StartingPointState({
    required this.child,
    this.fingerprint = true,
    this.pattern = true,
    this.pin = true,
    this.favAppBar,
    this.backgroundColor = Colors.black,
    this.mainTitle = const Text(
      'Choose your security method',
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),
    ),
    this.mainButtonStyle,
    this.fingerprintBackgroundColor = Colors.black,
    this.patternBackgroundColor = Colors.black,
    this.pinBackgroundColor = Colors.black,
    this.patternDimension = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: favAppBar ?? null,
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              mainTitle,
              SizedBox(
                height: 10,
              ),
              if (pin == true)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PinCodeScreen(
                          pinBackgroundColor: pinBackgroundColor,
                          child: child,
                          isFirsttime: true,
                          pinText: 'Create your PIN',
                        ),
                      ),
                    );
                  },
                  child: mainButtonStyle ??
                      Container(
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
                        child: Text(
                          'PIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                ),
              if (pattern)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pattern(
                          state: const [1],
                          dimension: patternDimension,
                          patternBackgroundColor: patternBackgroundColor,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: mainButtonStyle ??
                      Container(
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
                        child: Text(
                          'Pattern',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                ),
              if (fingerprint)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FingerPrint(
                          child: child,
                          fingerprintBackgroundColor:
                              fingerprintBackgroundColor,
                        ),
                      ),
                    );
                  },
                  child: mainButtonStyle ??
                      Container(
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
                        child: Text(
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

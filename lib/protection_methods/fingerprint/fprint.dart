import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:screen_protection/data/data.dart';
import 'package:screen_protection/protection_methods/fingerprint/screen_size_utils.dart';

class FingerPrint extends StatefulWidget {
  static const String fingerprintCreateRoute = '/fingerPrint';
  final Widget child;
  final Color? fingerprintBackgroundColor;
  const FingerPrint({
    super.key,
    required this.child,
    this.fingerprintBackgroundColor,
  });
  @override
  _FingerPrintState createState() => _FingerPrintState(
        child: child,
        fingerprintBackgroundColor: fingerprintBackgroundColor,
      );
}

class _FingerPrintState extends State<FingerPrint> {
  final Color? fingerprintBackgroundColor;
  bool isAuth = false;
  final Widget child;
  _FingerPrintState({
    required this.child,
    this.fingerprintBackgroundColor,
  });
  // check if the user has ability to use fingerprinting
  void checkFingerprint() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;

    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error checking biometrics: $e");
    }

    print("biometric is available: $canCheckBiometrics");

    List<BiometricType> availableBiometrics = [];
    try {
      // Retrieve the available biometrics on the device
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      print("\tfingerprint is available");
    } else {
      print("\tfingerprint is NOT available");
    }

    bool authenticated = false;

    try {
      // Perform biometric authentication (fingerprint)
      authenticated = await auth.authenticate(
          localizedReason: 'Please scan your fingerprint to login',
          options: const AuthenticationOptions(biometricOnly: true));
    } catch (e) {
      print("error using biometric auth: $e");
    }

    setState(() {
      isAuth = authenticated;
    });

    print("authenticated: $authenticated");
    if (isAuth) {
      // Navigate to the destination page (HomePage) after successful authentication
      Data.myData.put('secured', 1);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => child),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets buttonPadding = EdgeInsets.symmetric(
      horizontal: ScreenSizeUtils.calculateCircleSize(context, 0.1),
      vertical: ScreenSizeUtils.calculateCircleSize(context, 0.04),
    );

    final EdgeInsets pagePadding = EdgeInsets.only(
      top: ScreenSizeUtils.calculateCircleSize(context, 0.01),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: fingerprintBackgroundColor ?? Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          elevation: 0,
        ),
        body: SafeArea(
          // to create responsive layouts in Flutter applications.
          //It is a flexible widget that helps in adjusting the size
          // and position of its child widget based on the parent's constraints.
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FractionallySizedBox(
                      widthFactor: 1, // Adjust this value as needed for width
                      child: ElevatedButton(
                        onPressed: checkFingerprint,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[900],
                          onPrimary: Colors.white,
                          padding: buttonPadding,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Column(
                          // Use a Column to stack the icon and text vertically
                          children: [
                            Icon(
                              Icons.fingerprint,
                              size: ScreenSizeUtils.calculateCircleSize(
                                  context, 0.3),
                              color: Colors.blue,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Authenticate with Fingerprint",
                              style: TextStyle(
                                fontSize: ScreenSizeUtils.calculateCircleSize(
                                    context, 0.06),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

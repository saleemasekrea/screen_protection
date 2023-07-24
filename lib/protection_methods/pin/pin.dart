import 'package:flutter/material.dart';
import 'package:screen_protection/data/data.dart';
import 'package:screen_protection/protection_methods/fingerprint/screen_size_utils.dart';

class PinCodeScreen extends StatefulWidget {
  static const String pinCodeScreenLoginRoute = '/pinCodeScreen_login';
  static const String pinCodeScreenCreateRoute = '/pinCodeScreen_create';
  final String pinText;
  final bool isFirsttime;
  final Widget child;
  final Color? pinBackgroundColor;
  const PinCodeScreen(
      {super.key,
      required this.pinText,
      required this.isFirsttime,
      required this.child,
      this.pinBackgroundColor});

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState(
        pinBackgroundColor: pinBackgroundColor,
        child: child,
      );
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final Widget child;
  final Color? pinBackgroundColor;
  _PinCodeScreenState({
    required this.child,
    this.pinBackgroundColor,
  });
  late String enteredPin = '';

  void digitPressed(String digit) {
    if (enteredPin.length < 6) {
      enteredPin += digit;
    }
  }

  void deletePressed() {
    if (enteredPin.isNotEmpty) {
      enteredPin = enteredPin.substring(0, enteredPin.length - 1);
    }
  }

  void submitPressed() {
    if (enteredPin == Data.myData.get('PIN')) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('PIN entered correctly!'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => child),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('PIN entered incorrectly.'),
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
    enteredPin = '';
  }

  void savePIN() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to save the PIN?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                Navigator.pop(context);
                // Save the PIN
                await savePinToStorage(enteredPin);

                // Show success dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Success'),
                      content: Text('PIN entered correctly!'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PinCodeScreen(
                                  child: child,
                                  pinText: 'Enter your PIN',
                                  isFirsttime: false,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> savePinToStorage(String pin) async {
    await Data.myData.put('PIN', pin);
    await Data.myData.put('secured', 1);
  }

  Widget buildCircle(bool isActive, double size, Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.red : Colors.transparent,
        border: Border.all(
          color: Colors.cyanAccent,
          width: 2.0,
        ),
      ),
      child: child,
    );
  }

  Widget buildNumberCircle(String number, double size) {
    return buildCircle(
      enteredPin.length < 6,
      size,
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: CircleBorder(),
          minimumSize: Size(size, size),
          padding: EdgeInsets.all(size * 0.3),
        ),
        onPressed: () {
          setState(() {
            digitPressed(number);
          });
        },
        child: Text(
          number,
          style: TextStyle(
            fontSize: size * 0.5, // Adjusted number size
          ),
        ),
      ),
    );
  }

  Widget buildDeleteCircle(double size) {
    return buildCircle(
      enteredPin.isNotEmpty,
      size,
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: CircleBorder(),
          minimumSize: Size(size, size),
          padding: EdgeInsets.all(size * 0.3),
        ),
        onPressed: () {
          setState(() {
            deletePressed();
          });
        },
        child: Icon(
          Icons.backspace,
          size: size * 0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('PIN Screen'),
    );
    final double screenWidth = MediaQuery.of(context).size.width;
    final double availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final double fontSize = ScreenSizeUtils.calculateFontSize(context, 0.049);
    final double fontSubmit = ScreenSizeUtils.calculateFontSize(context, 0.027);
    final double smallCircleSize =
        ScreenSizeUtils.calculateCircleSize(context, 0.025);
    final double bigCircleSize =
        ScreenSizeUtils.calculateCircleSize(context, 0.1);

    return Scaffold(
      backgroundColor: pinBackgroundColor ?? Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  children: [
                    Text(
                      widget.pinText,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: availableHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < 6; i++)
                          buildCircle(
                            i < enteredPin.length,
                            smallCircleSize,
                            Container(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.07),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                shrinkWrap: true,
                itemCount: 12,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index < 9) {
                    return buildNumberCircle(
                        (index + 1).toString(), bigCircleSize);
                  } else if (index == 9) {
                    return buildNumberCircle('0', bigCircleSize);
                  } else if (index == 10) {
                    return buildDeleteCircle(bigCircleSize);
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan,
                          onPrimary: Colors.black,
                          shape: CircleBorder(),
                          minimumSize: Size(bigCircleSize, bigCircleSize),
                          padding: EdgeInsets.all(screenWidth * 0.035),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.isFirsttime ? savePIN() : submitPressed();
                          });
                        },
                        child: widget.isFirsttime
                            ? Text(
                                'Save',
                                style: TextStyle(fontSize: fontSubmit),
                              )
                            : Text(
                                'submit',
                                style: TextStyle(fontSize: fontSubmit),
                              ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

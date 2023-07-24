import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:screen_protection/data/data.dart';
import 'package:screen_protection/protection_methods/fingerprint/fprint.dart';
import 'package:screen_protection/protection_methods/pattern/pattern.dart';

import '../protection_methods/pin/pin.dart';

Future initialize() async {
  await Hive.initFlutter();
  await Hive.openBox('myData');
}

Future clear() async {
  await Data.myData.put('secured', null);
  await Data.myData.put('PIN', null);
  await Data.myData.put('pattern', null);
  await Data.myData.put('dim', null);
}

Widget callMethod(Widget realApp) {
  if (Data.myData.get('PIN') != null) {
    return PinCodeScreen(
      isFirsttime: false,
      pinText: 'Enter your PIN',
      child: realApp,
    );
  } else if (Data.myData.get('Finger') != null) {
    return FingerPrint(
      child: realApp,
    );
  } else {
    return Pattern(
      state: const [2],
      dimension: Data.myData.get('dim'),
      child: realApp,
    );
  }
}

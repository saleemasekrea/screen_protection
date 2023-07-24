# Protection screen
[![Flutter Version](https://img.shields.io/badge/flutter-%5E3.10.6-blue)](https://flutter.dev/)

[![Dart Version](https://img.shields.io/badge/dart-%5E3.0.6-blue)](https://dart.dev/)

The problem we identified is the need for enhanced security in our app. Many users store sensitive information within the app, making it crucial to protect their data from unauthorized access.
Our solution is to implement a protection screen that will act as a barrier to the app's content, requiring authentication before granting access.
## Features

This plugin provides you 3 different methods to add protection to your app

* PIN
* Pattern
* Fingerprint

with high preferable customization


## Demo

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/saleemasekrea/lock_screen/blob/main/images/1.jpg" width="600px" height="400px">
      <br />
    </td>
    <td align="center">
      <img src="https://github.com/saleemasekrea/lock_screen/blob/main/images/2.jpg" width="600px" height="400px">
      <br />
    </td>
    <td align="center">
      <img src="https://github.com/saleemasekrea/lock_screen/blob/main/images/3.jpg" width="600px" height="400px">
      <br />
    </td>
    <td align="center">
      <img src="https://github.com/saleemasekrea/lock_screen/blob/main/images/4.jpg" width="600px" height="400px">
      <br />    
    </td>
    <td align="center">
      <img src="https://github.com/saleemasekrea/lock_screen/blob/main/images/5.jpg" width="600px" height="400px">
      <br />   
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/saleemasekrea/lock_screen/blob/main/images/6.jpg" width="600px" height="400px">
      <br />  
    </td>
    <td align="center">
      <img src="https://github.com/saleemasekrea/lock_screen/blob/main/images/7.jpg" width="600px" height="400px">
      <br />  
    </td>
    <td align="center">
      <img src="https://github.com/saleemasekrea/lock_screen/blob/main/images/8.jpg" width="600px" height="400px">
      <br />  
    </td>
    <td align="center">
      <img src="https://github.com/saleemasekrea/lock_screen/blob/main/images/9.jpg" width="600px" height="400px">
      <br />  
    </td>
    <td align="center">
      <img src="https://github.com/saleemasekrea/lock_screen/blob/main/images/10.jpg" width="600px" height="400px">
      <br />  
    </td>
  </tr>
</table>

## How to Use
1- Go to `android/app/src/main/AndroidManifest.xml`

Add the following line to the `AndroidManifest.xml` file:
```xml
<uses-permission android:name="android.permission.USE_FINGERPRINT"/>
```
- this tag is used to declare permissions that your Android application requires to access certain features or resources on the device

2- Go to `android/app/src/main/kotlin/MainActivity.kt`

replace  the `MainActivity.kt` file with :
```xml
package com.example."the name of your project "
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
```
- This setup allows you to create a hybrid app with both native Android components and Flutter UI seamlessly integrated.

 -  make you main async (start the main with tow line):
 ```xml
 WidgetsFlutterBinding.ensureInitialized();
await initialize();
  ```
3- Go to `android/app/bulid.gradle` file
add to the `defaultConfig` this tow lines
```xml
multiDexEnabled true
minSDK 21
```
  - inside runApp call Protector and pass your Application entrie point us a child to the this class.

- to clear the saved authentication data call
```xml
clear()
```
4- the `usage` :

 - `pattern` : to give the user the accessability to 

 choose pattern method (true by default) (`bool`)


- `pin` : to give the user the accessability to choose 

pin method (true by default) (`bool`)


- `fingerprint` : to give the user the accessability to 

choose fingerprint method (true by default) (`bool`)


- `appBar` : pass your AppBar to override the default

 one (`AppBar`)


- `backgroundColor` : change the background color of the

 main screen (black by default) (`Color`)


- `mainTitle` : change the main title in the main screen

 ('Choose your security method' by default) (`Text`)


- `mainButtonStyle` : change how the button in the main

 screen looks like (no need to make it clickable) (`Widget`)


- `fingerprintBackgroundColor`: change the background 

color of the fingerprint screen (grey by default) (`Color`)

- `patternBackgroundColor`: change the background color

 of the pattern screen (black by default) (`Color`)


- `pinBackgroundColor`: change the background color of 

the pin screen (grey by default) (`Color`)

patternDimension: change the dimension of the pattern 

in the pattern screen (3 by default) (`int`)

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

# screen_protection

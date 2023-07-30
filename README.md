RRToast 
========= 
An easy to use flutter toast library with more features!

### Language: English | (README.md)

* [🕊️Overview](#Overview)
* [🐦Example](#Example)
* [🐮Getting started](#Getting-started) 
* [🦅3.0 version](#30-version)
* [📃Documentation](#Documentation) 

###  🕊️Overview

- In the true sense of Toast, you can call it whenever you need it, without any restrictions! 

- Feature-rich, support for displaying notifications, text, loading with image and circularProgressIndicator, attachments, etc. Toast

- Awesome customize widgets with Animations.

- Create Pop-ups, dialog widgets

- Support for popping up various custom Toasts, or you can pop up any Widget as long as it meets the requirements of the flutter code.

- Pure flutter implementation


### 🕊️Online Demo

**[Online demo](https://github.com/Ritikrai09/flutter_rr_toast/#/)** (Web effects may be biased, the actual effect is subject to the mobile phone)

### 🕊️Example
**[Sample project](example)**

### 🐮Getting started

#### 1. add dependencies into you project pubspec.yaml file
``` yaml
dependencies:
     flutter_rr_toast: ^0.0.1 
#null safety
```

#### 2. import RRToast lib
``` dart
import 'package:flutter_rr_toast/flutter_rr_toast.dart';
```

#### 3. initialization RRToast
``` dart
MaterialApp(
      title: 'RRToast Demo',
      builder: RRToastInit(), //1. call RRToastInit
      navigatorObservers: [RRToastNavigatorObserver()], //2. registered route observer
      home: XyzPage(),
  )
```
or
``` dart
//Warning: Don't arbitrarily adjust the position of calling the BotToastInit function 
final botToastBuilder = RRToastInit();  //1. call RRToastInit 
MaterialApp(
      title: 'RRToast Demo',
      builder: (context, child) {
        child = myBuilder(context,child);  //do something
        child = botToastBuilder(context,child); 
        return child;
      }, 
      navigatorObservers: [RRToastNavigatorObserver()], //2. registered route observer
      home: XyzPage(),
  )
```

#### 4. use RRToast
``` dart code
var cancel = RRToast.showText(text:"xyzxm");  //popup a text rr toast;
...
cancel();  //close
```

```dart code
var cancel = RRToast.showSimpleNotification(title: "init");
 // popup a notification rr toast;
...
cancel();  //close
```

```dart
var cancel = RRToast.showLoading(image: Image.asset('assets/img/xxxx.png')); 
//popup a loading rr toast with image as an optional.
...
cancel();  //close
```

```dart
var cancel = RRToast.showLoading(); 
//popup a loading rr toast with CircularProgressIndicator
...
cancel();  //close
```

```dart
//popup a attachments toast
var cancel = RRToast.showAttachedWidget(
    attachedBuilder: (_) => Card(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.bookmark,
              color: Colors.blueAccent,
            ),
          ),
        ),
    duration: Duration(seconds: 2.5),
    target: Offset(320, 320));
...
cancel();  //close
```

```dart
//custom api
var cancelToast = RRToast.showCustomNotification(...)
var cancelToast = RRToast.showCustomText(...)
var cancelToast = RRToast.showCustomLoading(...)
var cancelToast = RRToast.showAnimationWidget(...)
...
cancel();  //close
```

### 🐦3.0 version

``` dart
//3.x.x version initialization method
MaterialApp(
      title: 'RRToast Demo',
      builder: RRToastInit(), 
      navigatorObservers: [BotToastNavigatorObserver()],
      home: XxxxPage(),
  )
```


<br>


###  📃Documentation
[Documentation](API.md)




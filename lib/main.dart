import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tachymetre/utils/display_utils.dart';
import 'package:tachymetre/widgets/tachymetre.dart';

bool devMode = false;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        //systemNavigationBarColor: Colors.blue, // navigation bar color
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.light // status bar color
        ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(const MyApp());
}

MaterialColor mycolor = const MaterialColor(
  0xFF558B2F,
  <int, Color>{
    50: Color(0xff2C2C2C),
    100: Color(0xFF4C4C4C),
    200: Color(0xFF5C5C5C),
    300: Color(0xFF6C6C6C),
    400: Color(0xFF7C7C7C),
    500: Color(0xFF8C8C8C),
    600: Color(0xFF9C9C9C),
    700: Color(0xFFACACAC),
    800: Color(0xFFBCBCBC),
    900: Color(0xFFCCCCCC),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: mycolor,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int quarterTurns = devMode ? 0 : 3;
  bool mirror = !devMode;
  double brightness = 1.0;

  bool get isHorizontal => quarterTurns % 2 == 0;

  @override
  void initState() {
    super.initState();
    reset();
    initializer();
  }

  void initializer() async {
    // Get the current brightness:
    brightness = await DisplayUtils.currentBrightness;
    // Set the brightness:
    DisplayUtils.setBrightness(1.0);
    //Set keep display on
    DisplayUtils.enableKeepOn();
  }

  void reset() {
    setState(() {
      quarterTurns = devMode ? 0 : 3;
      mirror = !devMode;
    });
  }

  void quit({required bool shouldExit}) {
    try {
      DisplayUtils.setBrightness(brightness);
      DisplayUtils.disableKeepOn();

      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (shouldExit) {
        exit(0);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    quit(shouldExit: false); // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
//      extendBody :true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: () => setState(() {
          mirror = !mirror;
          quarterTurns += 2;
          if (quarterTurns >= 4) {
            quarterTurns -= 4;
          }
        }),
        onTap: () => setState(() {
          quarterTurns++;
          if (quarterTurns >= 4) {
            quarterTurns -= 4;
          }
          //textDisplayed = '120.$quarterTurns';
        }),
        child: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scaleY: mirror ? -1 : 1,
                  child: RotatedBox(
                    quarterTurns: quarterTurns,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Tachymetre(
                        width: isHorizontal ? screen.width : screen.height ,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (() => quit(shouldExit: true)),
        backgroundColor: Colors.black87,
        child: const Center(
          child: Text('X'),
        ),
      ),
    );
  }
}

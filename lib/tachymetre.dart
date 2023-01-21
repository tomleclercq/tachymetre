import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tachimeter/utils.dart';

class Tachymetre extends StatefulWidget {
  const Tachymetre({super.key});
  @override
  State<Tachymetre> createState() => _TachymetreState();
}

class _TachymetreState extends State<Tachymetre>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  double speedInKmphAdjusted = 0;
  Position? positionData;
  String? output = "stopped";
  bool checkDataRequired = false;

  Animation<double>? _animation;

  double get displayedValue {
    if (_animation != null) {
      return _animation!.value;
    } else {
      return speedInKmphAdjusted;
    }
  }

  String get textDisplayed {
    if (output != null) return output!;
    if (_animation != null) {
      return _animation!.value.addLeadingZeros(6);
    } else {
      return speedInKmphAdjusted.addLeadingZeros(6);
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(_controller!);

    _animation!.addListener(() {
      setState(() {});
    });
    reset();
    initializer();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  void initializer() async {
    final permission = await Geolocator.requestPermission();
    debugPrint(permission.name);
    setState(() {
      output = permission.name;
    });

    if (permission.index == 2 || permission.index == 3) {
      const locationSetting = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 2,
      );

      Geolocator.getPositionStream(locationSettings: locationSetting)
          .listen((position) {
        debugPrint('new location acquired');
        double speed = position.speed.toKmph;
        final factor = lerpDouble(0, 3, min(speed, 30) / 30) ?? 0;
        double speedMpsAdjusted = speed + factor;

        updateSpeed(speedMpsAdjusted);
        setState(() {
          positionData = position;
          output = null;
          checkDataRequired = true;
        });
      });
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (checkDataRequired && checkData()) {
          reset();
        }
      });
    } // while in use || always
  }

  bool checkData() {
    if (positionData != null) {
      if (positionData!.timestamp != null) {
        final dataTime = positionData!.timestamp!;
        final timeLimit = dataTime.add(const Duration(milliseconds: 2500));
        final nowUTC = DateTime.now().toUtc();
        if (nowUTC.isAfter(timeLimit)) {
          return true;
        }
      }
    }
    return false;
  }

  void updateSpeed(double newSpeedKmph) {
    _controller!.reset();
    _animation = Tween<double>(
      begin: speedInKmphAdjusted,
      end: newSpeedKmph,
    ).animate(_controller!);
    _controller!.forward();
    setState(() => speedInKmphAdjusted = newSpeedKmph);
  }

  void reset() {
    updateSpeed(0);
    setState(() {
      checkDataRequired = false;
    });
  }

  Color getTextColor() {
    Color textColor = const Color.fromARGB(255, 140, 255, 87);
    if (speedInKmphAdjusted > (30 / 3.6) && speedInKmphAdjusted < (50 / 3.6)) {
      textColor = const Color.fromARGB(255, 143, 201, 255);
    }
    if (speedInKmphAdjusted >= (50 / 3.6) && speedInKmphAdjusted < (90 / 3.6)) {
      textColor = const Color.fromARGB(255, 255, 188, 150);
    }
    if (speedInKmphAdjusted >= (120 / 3.6)) {
      textColor = const Color.fromARGB(255, 255, 214, 188);
    }
    if (speedInKmphAdjusted >= (125 / 3.6)) {
      textColor = const Color.fromARGB(255, 255, 87, 124);
    }
    return textColor;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      textDisplayed,
      overflow: TextOverflow.fade,
      softWrap: true,
      maxLines: 3,
      style: GoogleFonts.robotoMono(
        fontWeight: FontWeight.w200,
        fontSize:
            output != null ? 55 : 220, // quarterTurns % 2 == 0 ? 100 : 200,
        color: getTextColor(),
      ),
    );
  }
}

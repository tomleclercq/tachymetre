import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tachymetre/utils/utils.dart';
import 'package:tachymetre/widgets/graph.dart';

import '../models/data_point.dart';

class Tachymetre extends StatefulWidget {
  const Tachymetre({required this.width, super.key});
  final double width;
  @override
  State<Tachymetre> createState() => _TachymetreState();
}

class _TachymetreState extends State<Tachymetre>
    with SingleTickerProviderStateMixin {
  ///State properties
  AnimationController? _controller;
  Animation<double>? _animation;
  double _speedInKmphAdjusted = 0;
  String? _output = 'stopped';
  Timer? _dataChecker;
  List<DataPoint> _dataHistory = [];
  Position? positionData;
  bool dataReset = false;

  double get displayedValue {
    return _animation != null ? _animation!.value : _speedInKmphAdjusted;
  }

  String get textDisplayed {
    final rounded = MathUtils.round(displayedValue, 0).ceil();
    return rounded.addLeadingSpace(3);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 125,
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
    _dataChecker?.cancel();
  }

  void initializer() async {
    final permission = await Geolocator.requestPermission();
    debugPrint(permission.name);
    setState(() {
      _output = permission.name;
    });

    if (permission.index == 2 || permission.index == 3) {
      const locationSetting = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      );

      Geolocator.getPositionStream(locationSettings: locationSetting)
          .listen((position) {
        double speed = position.speed.toKmph;
        final factor = lerpDouble(0, 1, min(speed, 75) / 100) ?? 0;
        double speedMpsAdjusted = speed + factor;

        DataPoint currentDataPoint = DataPoint(
          positionData: position,
          dataReset: false,
        );
        bool storeDataPoint = false;

        if (_dataHistory.isEmpty) {
          storeDataPoint = true;
        } else {
          final lastStoredDataPointDelayed =
              _dataHistory.last.positionData?.timestamp;
          final diff = lastStoredDataPointDelayed == null
              ? null
              : DateTime.now().difference(lastStoredDataPointDelayed).inSeconds;
          if (diff != null && diff >= 60) {
            storeDataPoint = true;
          }
        }
        if (storeDataPoint) {
          final len = _dataHistory.length;
          debugPrint('StoreData [$len]');
          if (len > 30) {
            _dataHistory.removeAt(0);
          }
          setState(() => _dataHistory = [..._dataHistory, currentDataPoint]);
        }
        setState(
          () {
            _output = 'km/h';
            positionData = position;
            dataReset = false;
          },
        );

        updateSpeed(speedMpsAdjusted);
      });

      _dataChecker = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        if (!dataReset && checkData()) {
          reset();
        }
      });
    } // while in use || always
  }

  bool checkData() {
    if (positionData != null && positionData!.timestamp != null) {
      DateTime timeLimit = positionData!.timestamp!;
      timeLimit = timeLimit.add(const Duration(milliseconds: 3500));
      final nowUTC = DateTime.now().toUtc();
      if (nowUTC.isAfter(timeLimit)) {
        return true;
      }
    }
    return false;
  }

  void updateSpeed(double newSpeedKmph, {bool reset = false}) {
    Duration newDuration = const Duration(milliseconds: 16);
    if (reset) {
      _controller!.stop();
    } else {
      final delta = (newSpeedKmph - _speedInKmphAdjusted).abs();
      if (delta >= 0.2) {
        _controller!.reset();
        final timeFactor = max(0.05, min((delta / 120), 0.8)) * 1000;
        newDuration =
            Duration(milliseconds: delta > 30 ? 5 : (timeFactor).toInt());
        _controller?.duration = newDuration;
      }
    }
    _animation = Tween<double>(
      begin: _speedInKmphAdjusted,
      end: newSpeedKmph,
    ).animate(_controller!);
    _controller!.forward();
    setState(() {
      dataReset = reset;
      _speedInKmphAdjusted = newSpeedKmph;
    });
  }

  void reset() {
    debugPrint('reset ${DateTime.now().toIso8601String()}');

    updateSpeed(0, reset: true);
  }

  Color getTextColor(double speed) {
    Color textColor = AppColors.neutral;

    if (speed > 28 && speed <= 32 ||
        speed >= 48 && speed <= 52 ||
        speed >= 68 && speed <= 72 ||
        speed >= 98 && speed <= 102 ||
        speed >= 118 && speed < 122) {
      textColor = AppColors.good;
    } else if (speed >= 122 && speed < 125) {
      textColor = AppColors.warning;
    } else if (speed >= 125) {
      textColor = AppColors.alert;
    }
    return textColor;
  }

  @override
  Widget build(BuildContext context) {
    return Graph(
      width: MediaQuery.of(context).size.width,
      input: displayedValue,
      history: _dataHistory,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _output ?? '-',
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w200,
                  fontSize: 32,
                  color: AppColors.neutral,
                ),
              ),
              Text(
                textDisplayed,
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w200,
                  fontSize: 220,
                  color: getTextColor(displayedValue),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _output != null ? 100 : 70,
            width: widget.width,
          ),
        ],
      ),
    );
  }
}

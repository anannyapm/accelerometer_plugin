import 'dart:async';
import 'package:flutter/services.dart';

class AccelerometerPlugin {
  static const MethodChannel _channel = MethodChannel('accelerometer_plugin');

  static Stream<Map<String, double>> get accelerometerStream {
    return _eventChannel.receiveBroadcastStream().map((data) {
      return {
        'x': data[0],
        'y': data[1],
        'z': data[2],
      };
    });
  }

  static const EventChannel _eventChannel =
      EventChannel('accelerometer_plugin/stream');
}

import 'dart:async';

import 'package:accelerometer_plugin/accelerometer_plugin.dart';
import 'package:get/get.dart';

class AccelerometerController extends GetxController {
  var x = 0.0.obs;
  var y = 0.0.obs;
  var z = 0.0.obs;

  var isListening = false.obs;

  StreamSubscription? _streamSubscription;

  void startListening() {
    if (!isListening.value) {
      _streamSubscription =
          AccelerometerPlugin.accelerometerStream.listen((data) {
        x.value = data['x'] ?? 0.0;
        y.value = data['y'] ?? 0.0;
        z.value = data['z'] ?? 0.0;
      });
      isListening.value = true;
    }
  }

  void stopListening() {
    _streamSubscription?.cancel();
    isListening.value = false;
  }

  @override
  void onClose() {
    stopListening();
    super.onClose();
  }
}

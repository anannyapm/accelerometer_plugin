import 'package:accelerometer_plugin_example/controller/motion_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final AccelerometerController controller = Get.put(AccelerometerController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accelerometer Data',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 10,
      ),
      body: SafeArea(
        child: Center(
          child: Obx(() {
            return Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSensorValue('X', controller.x.value),
                    const SizedBox(height: 20),
                    _buildSensorValue('Y', controller.y.value),
                    const SizedBox(height: 20),
                    _buildSensorValue('Z', controller.z.value),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSensorValue(String axis, double value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$axis:',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value.toStringAsFixed(2),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

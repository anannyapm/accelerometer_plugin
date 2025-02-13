package com.example.accelerometer_plugin

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.BinaryMessenger // Add this import

class AccelerometerPlugin : FlutterPlugin, EventChannel.StreamHandler, SensorEventListener {
    private var eventSink: EventChannel.EventSink? = null
    private lateinit var sensorManager: SensorManager
    private var accelerometer: Sensor? = null
    private lateinit var channel: EventChannel

    // For compatibility with older Flutter versions
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val plugin = AccelerometerPlugin()
            plugin.setupEventChannel(registrar.messenger(), registrar.context())
        }
    }

    // FlutterPlugin methods
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        setupEventChannel(flutterPluginBinding.binaryMessenger, flutterPluginBinding.applicationContext)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setStreamHandler(null)
    }

    private fun setupEventChannel(messenger: BinaryMessenger, context: Context) {
        channel = EventChannel(messenger, "accelerometer_plugin/stream")
        channel.setStreamHandler(this)
        sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
        if (accelerometer == null) {
            throw RuntimeException("Accelerometer sensor not available!")
        }
    }

    // EventChannel.StreamHandler methods
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        sensorManager.registerListener(this, accelerometer, SensorManager.SENSOR_DELAY_NORMAL)
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
        sensorManager.unregisterListener(this)
    }

    // SensorEventListener methods
    override fun onSensorChanged(event: SensorEvent?) {
        event?.let {
            val x = it.values[0]
            val y = it.values[1]
            val z = it.values[2]
            eventSink?.success(listOf(x, y, z))
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
}
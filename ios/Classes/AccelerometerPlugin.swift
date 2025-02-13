import CoreMotion
import Flutter

public class AccelerometerPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  private var motionManager: CMMotionManager?
  private var eventSink: FlutterEventSink?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = AccelerometerPlugin()
    let eventChannel = FlutterEventChannel(
      name: "accelerometer_plugin/stream", binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(instance)
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink)
    -> FlutterError?
  {
    self.eventSink = events
    startAccelerometerUpdates()
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    stopAccelerometerUpdates()
    return nil
  }

  private func startAccelerometerUpdates() {
    motionManager = CMMotionManager()
    motionManager?.accelerometerUpdateInterval = 0.1
    motionManager?.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
      guard let data = data else { return }
      let x = data.acceleration.x
      let y = data.acceleration.y
      let z = data.acceleration.z
      self.eventSink?([x, y, z])
    }
  }

  private func stopAccelerometerUpdates() {
    motionManager?.stopAccelerometerUpdates()
    motionManager = nil
  }
}

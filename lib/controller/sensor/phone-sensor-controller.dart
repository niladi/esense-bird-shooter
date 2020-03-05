
import 'package:flutter/cupertino.dart';
import 'package:mciot_game/controller/sensor/sensor-controller.dart';
import 'package:sensors/sensors.dart';



class PhoneSensorController extends SensorController<GyroscopeEvent>{



  PhoneSensorController(OnData onData) : super(onData) {
    sensorScale = 8 ;
  }

  void register() {
    streamSubscription = gyroscopeEvents.listen((event) => transform(event));
  }

  void transform(GyroscopeEvent event) {
    onData(new Offset(event.x * sensorScale, (-1) * event.y * sensorScale));
  }

}
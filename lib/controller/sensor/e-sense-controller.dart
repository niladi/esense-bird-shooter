
import 'dart:async';
import 'dart:ui';

import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';
import 'package:mciot_game/controller/sensor/sensor-controller.dart';

class ESenseController extends SensorController<SensorEvent> {

  bool sampling = false;

  String _status;
  String get status => _status;

  // the name of the eSense device to connect to -- change this to your own device.
  String eSenseName = 'eSense-0569';

  ESenseController(OnData onData) : super(onData) {
    sensorScale = 0.0001 ;
    _connectToESense();
  }


  Future<void> _connectToESense() async {
    bool con = false;
    connected = false;
    // if you want to get the connection events when connecting, set up the listener BEFORE connecting...
    ESenseManager.connectionEvents.listen((event) {
      if (event.type == ConnectionType.connected) {
        connected = true;
        _status = 'connected';
      } else {
        connected = false;
        if (event.type == ConnectionType.device_found) {
          _status = 'connecting';
        } else {
          _status = 'disconected';
          Timer(new Duration(seconds: 3), _startConnection);
        }
      }
    });

    _startConnection();

  }

  Future<void> _startConnection() async{
    if (await ESenseManager.connect(eSenseName)) {
    _status = 'connecting';
    } else {
    _status = 'connecting failed';
    }
  }

  void _listenToESenseEvents() async {
    ESenseManager.eSenseEvents.listen((event) {
      print('ESENSE event: $event');
    });

    _getESenseProperties();
  }

  void _getESenseProperties() async {
    // get the battery level every 10 secs
    Timer.periodic(Duration(seconds: 10), (timer) async => await ESenseManager.getBatteryVoltage());

    // wait 2, 3, 4, 5, ... secs before getting the name, offset, etc.
    // it seems like the eSense BTLE interface does NOT like to get called
    // several times in a row -- hence, delays are added in the following calls
    Timer(Duration(seconds: 2), () async => await ESenseManager.getDeviceName());
    Timer(Duration(seconds: 3), () async => await ESenseManager.getAccelerometerOffset());
    Timer(Duration(seconds: 4), () async => await ESenseManager.getAdvertisementAndConnectionInterval());
    Timer(Duration(seconds: 5), () async => await ESenseManager.getSensorConfig());
  }



  @override
  void register() {
    ESenseManager.setSamplingRate(50);
    streamSubscription = ESenseManager.sensorEvents.listen((SensorEvent event)  =>  transform(event));
  }

  @override
  void transform(SensorEvent event) {
    double x = event.gyro[1].toDouble() * sensorScale;
    double y = (-1) * event.gyro[2].toDouble() * sensorScale;
    onData(new Offset(x, y));
  }

}

import 'dart:async';

import 'package:flutter/cupertino.dart';


typedef void OnData(Offset offset);

abstract class SensorController<T> {

  @protected
  OnData onData;

  @protected
  double sensorScale = 1;

  @protected
  bool connected = false;

  @protected
  StreamSubscription<T> streamSubscription;

  bool get isConnected => this.connected;

  SensorController(this.onData);


  @protected
  void transform(T event);

  void register();

  void start() {
    if (streamSubscription == null) {
      register();
    } else {
      streamSubscription.resume();
    }
  }

  void stop() async{
    streamSubscription = await streamSubscription?.cancel();
  }



}
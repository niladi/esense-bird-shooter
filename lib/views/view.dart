
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:mciot_game/mciot-game.dart';

abstract class View {

  @protected
  final MCIOTGame game;

  View (this.game);

  void render(Canvas c);

  void update(double t);

  void onTapDown(TapDownDetails d);

  void viewEnter();

  void viewLeave();
}
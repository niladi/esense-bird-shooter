import 'dart:io';

import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mciot_game/components/birds/bird-factory.dart';
import 'package:mciot_game/components/birds/rose-bird.dart';
import 'package:mciot_game/mciot-game.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<String> images = new List.from(<String>[
    'bg/Full-Background.png',
    'bg/layer-1.png',
    'bg/layer-2.png',
    'bg/layer-3.png',
    'buttons/play.png',
    'buttons/update.png'
  ])
  ..addAll(BirdFactory.pictures);

  Flame.images.loadAll(images);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeLeft);

  MCIOTGame game = MCIOTGame();
  runApp(game.widget);


  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);

}

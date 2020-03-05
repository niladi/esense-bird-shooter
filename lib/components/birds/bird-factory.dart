
import 'dart:math';

import 'package:mciot_game/components/birds/bird.dart';
import 'package:mciot_game/components/birds/blue-bird.dart';
import 'package:mciot_game/components/birds/good-bird.dart';
import 'package:mciot_game/components/birds/layers.dart';
import 'package:mciot_game/components/birds/rose-bird.dart';
import 'package:mciot_game/components/birds/monster-bird.dart';
import 'package:mciot_game/mciot-game.dart';

import '../direction.dart';

class BirdFactory {

  static List<String> get pictures => new List
      .from(RoseBird.pictures)
      ..addAll(MonsterBird.pictures)
      ..addAll(BlueBird.pictures);

  static Bird createRandomBird(Random random,MCIOTGame game,Direction direction,double speed,Layers layer) {
    switch (random.nextInt(4)) {
      case 0: return new RoseBird(game, direction, speed, layer); break;
      case 1: return new BlueBird(game, direction, speed, layer); break;
      case 2: return new MonsterBird(game, direction, speed, layer); break;
      default: return new GoodBird(game, direction, speed, layer);
    }

  }


}


import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:mciot_game/components/birds/layers.dart';
import 'package:mciot_game/components/moving-component.dart';
import 'package:mciot_game/components/direction.dart';
import 'package:mciot_game/components/birds/lifecycle.dart';
import 'package:mciot_game/mciot-game.dart';

abstract class Bird extends MovingComponent {

  Lifecycle _lifecycle;
  Lifecycle get lifecycle => _lifecycle;

  int _scoreAmount;

  Sprite _dying;

  Bird(MCIOTGame game, Direction direction, double speed, Layers layer, this._scoreAmount, double width, {double height = -1 })
      : super(game, direction, speed, layer ,width, height: height) {
    _lifecycle = Lifecycle.alive;
    _dying = initDying;
  }

  Sprite get initDying;

  @override
  Offset nextStep(t) {
    double stepDistance = speed * t;
    return Offset(_lifecycle == Lifecycle.alive?direction.moveX(stepDistance): 0, _lifecycle.moveY(stepDistance));
  }

  @override
  Sprite get sprite => Lifecycle.alive == _lifecycle ? this.moves[index.toInt()] : _dying;

  @override
  void onUpdate(){
    if (game.map.isOutOfXBounce(direction, rect) || (_lifecycle.isDying && game.map.isOutOfBottomBounce(rect))) {
      _lifecycle = Lifecycle.dead;
    }
  }

  void onHit() {
    if (_lifecycle == Lifecycle.alive) {
      _lifecycle = Lifecycle.dying;
      game.addScore(layer.scoreAmmount(_scoreAmount));
    }
  }

}
import 'dart:ui';


import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart';
import 'package:mciot_game/components/birds/layers.dart';
import 'package:mciot_game/components/direction.dart';
import 'package:mciot_game/mciot-game.dart';

abstract class MovingComponent {
  @protected
  final MCIOTGame game;

  @protected
  final Direction direction;

  @protected
  final double speed;

  final Layers layer;

  @protected
  static String get name {
    return '';
  }

  AnimationComponent com;

  List<Sprite> _moves;

  double index;

  Rect _rect;

  @protected
  Rect get rect => _rect;



  MovingComponent(this.game, this.direction, this.speed, this.layer, double width, {double height = -1 }) {
    _moves = initMoves;
    com = AnimationComponent(64.0, 64.0, new Animation.spriteList(initMoves, stepTime: 0.01));
    _rect = Rect.fromLTWH(
        game.map.getSpawnX(direction, width),
        game.map.getSpawnY(layer),
        width * layer.sizeMultiplier ,
        (height == -1 ? width : height) * layer.sizeMultiplier);

    index = 0;
  }

  List<Sprite> get moves => _moves;

  @protected
  List<Sprite> get initMoves;

  @protected
  Sprite get sprite;

  @protected
  Offset nextStep(t);

  @protected
  void onUpdate() {}

  static List<String> _getMovesPath (int number,String name ,Direction direction, { String fileType = 'png' }) {
    List<String> moves = new List<String>();
    for (int i = 1; i <= number; i++) {
      moves.add('birds/$name/frame-${direction.fileShort}-$i.$fileType');
    }
    return moves;
  }

  static String _getDyingPath(String name, Direction direction ,{ String fileType = 'png' }) {
    return 'birds/$name/frame-${direction.fileShort}-d.$fileType';
  }

  List<Sprite> movesLoader(int number, String name,{ String fileType = 'png' }) {
    List<Sprite> moves = new List<Sprite>();
    _getMovesPath(number,name, direction, fileType: fileType).forEach((String s) => moves.add(new Sprite(s)));
    return moves;
  }

  Sprite dyingLoader(String name, { String fileType = 'png' }) {
    return Sprite(_getDyingPath(name, direction, fileType: fileType));
  }

  static List<String> _picturesDirection(int number, String name, Direction direction, {String fileType = 'png'}) {
    return new List.from(_getMovesPath(2, name, direction, fileType:fileType))
        ..add(_getDyingPath(name, direction, fileType:fileType));

  }

  static List<String> pictures ( int number, String name, {String fileType = 'png'}) {
    return Direction.values
        .map((Direction direction) => _picturesDirection(number, name, direction, fileType: fileType))
        .expand((x) => x).toList();
  }


  void render(Canvas c) {
    this.sprite.renderRect(c, rect.inflate(2));
  }

  void update(double t) {
    index += 30 / moves.length  * t;
    if (index >= moves.length ) {
      index -=  moves.length;
    }
    _rect = game.map.getPosition(rect.shift(nextStep (t)));

    onUpdate();
  }

  bool rectContains(Offset offset) {
    return rect.contains(offset);
  }
}
import 'dart:ui';
import 'package:flame/components/animation_component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:mciot_game/components/birds/layers.dart';
import 'package:mciot_game/components/direction.dart';
import 'package:mciot_game/mciot-game.dart';


class MapComponent {
  final MCIOTGame _game;
  List<List<Sprite>> _layer;

  Rect _rect;
  double get left => _rect.left;
  double get right => _rect.right;
  double get top => _rect.top;
  double get bottom => _rect.bottom;

  
  Offset _move = Offset.zero;
  Offset _init;
  double _mapWidth;
  double _mapHeight;

  MapComponent(this._game, this._mapWidth, this._mapHeight) {
    _layer = new List();
    _layer.add([Sprite('bg/layer-1.png')]);
    _layer.add([Sprite('bg/layer-2.png')]);
    _layer.add([Sprite('bg/layer-3.png')]);

    initGame();

  }

  void initGame() {
    _rect = Rect.fromLTWH(
      (_mapWidth - _game.screenWidth) / -2,
      (_mapHeight - _game.screenHeight) / -2,
      _mapWidth,
      _mapHeight,
    );
    updateInitAcceleration();
  }

  void updatePosition(Offset offset) {
    if (_init == null) {
      _init = offset;
    }
    _move = offset - _init;
  }

  void updateAcceleration(Offset offset) {
    if (_init == null) {
      _init = offset;
    }

    _move += offset - _init;
    print(_move);
  }

  void updateInitAcceleration() {

    _init = null;
    _move = Offset.zero;
  }

  void render(Canvas c, int layer) {
    this._layer[layer].forEach((Sprite s) => s.renderRect(c, _rect));
  }

  void update(double t) {
    Rect rect = _rect.shift(_move);
    double x = _move.dx;
    double y = _move.dy;

    if (rect.left > 0) {
      x = (-1) * left;
    } else if (rect.left < _game.screenWidth - _mapWidth) {
      x = _game.screenWidth - _mapWidth - left;
    }

    if (rect.top > 0) {
      y = (-1) * top;
    } else if (rect.top < _game.screenHeight - _mapHeight) {
      y = _game.screenHeight - _mapHeight - top;
    }

    _move = new Offset(x, y);
    _rect = _rect.shift(_move);
  }

  bool isOutOfXBounce(Direction direction, Rect rect) {
    return direction.isLeft ? _isOutOfRightBounce(rect) : _isOutOfLeftBounce(rect);
  }

  bool _isOutOfLeftBounce(Rect rect) {
    return rect.right < left;
  }

  bool _isOutOfRightBounce(Rect rect) {
    return rect.left > right;
  }

  bool isOutOfBottomBounce(Rect rect) {
    return rect.top > bottom;
  }
  

  double getSpawnY(Layers layer) {
    switch (layer) {
      case Layers.back:
        return _game.rnd.nextDouble() * (top + _mapHeight/2);
        break;
      case Layers.front:
        return _game.rnd.nextDouble() * (top + _mapHeight/2) + _mapHeight/2 - 3 * _game.tileSize;
        break;
    }
    return 0;
  }

  double getSpawnX(Direction direction,double width) {
    return direction.isLeft ? right: left - width;
  }

  Rect getPosition(Rect c) {
    return c.shift(_move);
  }
}
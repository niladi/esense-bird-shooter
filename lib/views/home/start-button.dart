
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:mciot_game/mciot-game.dart';

class StartButton {
  final MCIOTGame _game;
  Rect _rect;
  Sprite _sprite;

  StartButton(this._game) {
    _rect = Rect.fromLTWH(
      _game.screenWidth / 2 - _game.tileSize,
      _game.screenHeight / 2 - 0.5 * _game.tileSize,
      _game.tileSize * 2,
      _game.tileSize,
    );
    _sprite = Sprite('buttons/play.png');
  }

  void render(Canvas c) {
    _sprite.renderRect(c, _rect);
  }

  void update(double t) {}

  bool rectContains(Offset offset) {
    return _rect.contains(offset);
  }

  void onTapDown() {
    _game.startGame();
  }
}
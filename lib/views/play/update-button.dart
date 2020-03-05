
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:mciot_game/mciot-game.dart';

class UpdateButton {
  final MCIOTGame _game;
  Rect _rect;
  Sprite _sprite;

  UpdateButton(this._game) {
    _rect = Rect.fromLTWH(
      _game.screenWidth - _game.tileSize,
      _game.screenHeight - _game.tileSize * 0.5,
      _game.tileSize,
      _game.tileSize * 0.5,
    );
    _sprite = Sprite('buttons/update.png');
  }

  void render(Canvas c) {
    _sprite.renderRect(c, _rect);
  }

  bool rectContains(Offset offset) {
    return _rect.contains(offset);
  }

  void update(double t) {}

  void onTapDown() {
    _game.map.updateInitAcceleration();
  }
}
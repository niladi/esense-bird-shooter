import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:mciot_game/mciot-game.dart';

class HighScoreDisplay {
  final MCIOTGame _game;
  TextPainter _painter;
  TextStyle _textStyle;
  Offset _position;

  HighScoreDisplay(this._game) {
    _painter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    _textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: _game.tileSize * 0.5,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    _position = Offset(
      0,
      _game.screenHeight - _game.tileSize * 0.5,
    );

    update();
  }

  void render(Canvas c) {
    _painter.paint(c, _position);
  }

  void update() {
    _painter.text = TextSpan(
      text: _game.highScore.toString(),
      style: _textStyle,
    );

    _painter.layout();
  }

}
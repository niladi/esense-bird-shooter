import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:mciot_game/mciot-game.dart';

class ScoreDisplay {
  
  final MCIOTGame _game;
  TextPainter _painter;
  TextStyle _textStyle;
  Offset _position;

  ScoreDisplay(this._game) {
    _painter = TextPainter(
      textAlign: TextAlign.center,
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


  }

  void render(Canvas c) {
    _painter.paint(c, _position);
  }

  void update(double t) {
    if ((_painter.text?.toPlainText() ?? '') != _game.score.toString()) {
      _painter.text = TextSpan(
        text: ' ' + _game.score.toString() + '|' + _game.timer.toInt().toString(),
        style: _textStyle,
      );

      _painter.layout();

      _position = Offset(
        _game.screenWidth/ 2 - _painter.width/2,
        _game.screenHeight - _game.tileSize * 0.5,
      );
    }
  }
}
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:mciot_game/mciot-game.dart';
import 'package:mciot_game/views/home/esense-status-display.dart';
import 'package:mciot_game/views/home/high-score-display.dart';
import 'package:mciot_game/views/home/start-button.dart';
import 'package:mciot_game/views/view.dart';


class HomeView extends View{
  Sprite _bgSprite;
  Rect _bgRect;
  StartButton _startButton;
  HighScoreDisplay _highScoreDisplay;
  EsenseStatusDisplay _esenseStatusDisplay;

  HomeView(MCIOTGame game) : super( game ) {
    _bgSprite = Sprite('bg/Full-Background.png');
    _bgRect = Rect.fromLTWH(
      0,0,
      game.screenWidth,
      game.screenHeight,
    );
    _startButton = new StartButton(game);
    _highScoreDisplay = new HighScoreDisplay(game);
    _esenseStatusDisplay = new EsenseStatusDisplay(game);
  }

  @override
  void render(Canvas c) {
    _bgSprite.renderRect(c, _bgRect);
    _startButton.render(c);
    _highScoreDisplay.render(c);
    _esenseStatusDisplay.render(c);
  }

  void update(double t) {
    _esenseStatusDisplay.update();
  }

  void onTapDown(TapDownDetails d) {
    if (_startButton.rectContains(d.globalPosition)) {
      _startButton.onTapDown() ;
    }
  }

  @override
  void viewEnter() {
    _highScoreDisplay.update();
  }

  @override
  void viewLeave() {
    // TODO: implement viewLeave
  }


}
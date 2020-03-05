import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:mciot_game/components/birds/bird-factory.dart';
import 'package:mciot_game/components/birds/bird.dart';
import 'package:mciot_game/components/birds/layers.dart';
import 'package:mciot_game/components/birds/rose-bird.dart';
import 'package:mciot_game/components/direction.dart';
import 'package:mciot_game/components/map-component.dart';
import 'package:mciot_game/controller/sensor/e-sense-controller.dart';
import 'package:mciot_game/controller/sensor/phone-sensor-controller.dart';
import 'package:mciot_game/controller/sensor/sensor-controller.dart';
import 'package:mciot_game/views/home/home-view.dart';
import 'package:mciot_game/views/play/play-view.dart';
import 'package:mciot_game/views/view.dart';
import 'package:mciot_game/views/views.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MCIOTGame extends Game {
  SharedPreferences _storage;

  Random _random;
  Random get rnd => _random;

  MapComponent _map;
  MapComponent get map => _map;

  Views activeView;
  Map<Views, View> views;

  PhoneSensorController _phoneSensorController;
  ESenseController _eSenseController;
  SensorController _activeSensorController;

  String get esenseState => _eSenseController?.status ?? 'controller not activ';

  Size _screenSize;
  double get screenWidth => _screenSize.width;
  double get screenHeight => _screenSize.height;

  double _tileSize;
  double get tileSize => _tileSize;

  List<Bird> birds;

  int _score;
  void addScore(int value) => _score += value;
  int get score => _score;


  double _timer = 0;
  double get timer => _timer;

  int get highScore => _storage.getInt('highscore') ?? 0;

  Timer _spawnTimer;




  MCIOTGame () {
    initialize();
  }

  void initialize() async {
    _random = Random();
    resize(await Flame.util.initialDimensions());
    _storage = await SharedPreferences.getInstance();


    birds = new List<Bird>();
    _map = new MapComponent(
        this,
        screenWidth * 2,
        screenHeight * 2);
    views = new Map<Views, View>();
    views[Views.home] = new HomeView(this);
    views[Views.playing] = new PlayView(this);

    changeView(Views.home);

    _eSenseController = new ESenseController((Offset offset) => map.updateAcceleration(offset));
    _phoneSensorController = new PhoneSensorController((Offset offset) => map.updatePosition(offset));


  }

  void spawnBird() {
    birds.add(BirdFactory.createRandomBird(
        rnd,
        this,
        DirectionExtention.random(rnd),
        (rnd.nextInt(20) + 40).toDouble(),
        LayersExtention.random(rnd)));
  }


  void render(Canvas canvas) {
    views[activeView]?.render(canvas);
  }

  void update(double t) {
    _timer -= t;
    views[activeView]?.update(t);
  }

  void resize(Size size) {
    _screenSize = size.width < size.height ? size.flipped : size ;
    _tileSize = screenWidth / 9;
  }

  void onTapDown(TapDownDetails d) {
    views[activeView].onTapDown(d);
  }

  void startGame() {
    _score = 0;

    for (int i = 0; i <= rnd.nextInt(8); i++) {
      spawnBird();
    }
    _map.initGame();
    _spawnTimer = Timer.periodic(new Duration(seconds: 2),(timer) => spawnBird());
    changeView(Views.playing);
    _activeSensorController = _eSenseController.isConnected ? _eSenseController : _phoneSensorController;
    _activeSensorController.start();
    _timer = 30;
  }

  void stopGame() {
    birds = new List<Bird>();
    if (_score > highScore) {
      _storage.setInt('highscore', _score);
    }
    _spawnTimer.cancel();

    changeView(Views.home);
    _activeSensorController.stop();
  }

  void changeView(Views view) {
    views[activeView]?.viewLeave();
    activeView = view;
    views[activeView].viewEnter();
  }

}

import 'dart:async';
import 'package:flutter/material.dart';

import 'base_event.dart';

import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  StreamController<bool> _loadingStreamController = StreamController<bool>();

  Sink<BaseEvent> get event => _eventStreamController.sink;

  Stream<bool> get loadingStream => _loadingStreamController.stream;
  Sink<bool> get loadingSink => _loadingStreamController.sink;
  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) throw Exception("Not base event");
      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent baseEvent);

  @mustCallSuper
  dispose() {
    _eventStreamController.close();
    _loadingStreamController.close();
  }
}

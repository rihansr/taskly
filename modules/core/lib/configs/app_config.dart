import 'package:flutter/foundation.dart';

enum _AppMode { debug, production }

final appConfig = _AppConfig.value;

class _AppConfig {
  static _AppConfig get value => _AppConfig._();
  _AppConfig._();

  final appMode = kDebugMode ? _AppMode.debug : _AppMode.production;
  late Map<String, dynamic> config;

  init() {
    config = _configs[appMode.name] ?? {};
  }

  final _configs = {
    "debug": {
      "base_url": "https://api.todoist.com/rest/v2",
    },
    "production": {
      "base_url": "https://api.todoist.com/rest/v2",
    }
  };
}

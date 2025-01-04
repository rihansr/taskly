library utils;
export 'constants.dart';
export 'debug.dart';
export 'encryptor.dart';
export 'enums.dart';
export 'extensions/extensions.dart';
export 'validator.dart';
export 'package:dartz/dartz.dart';

final utils = _Utils.instance;

class _Utils {
  static _Utils get instance => _Utils._();
  _Utils._();
}

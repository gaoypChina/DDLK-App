class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }
}

abstract class BaseConfig {
  String get apiHost;
  String get nameEnv;
  String get domain;
  String get mapAccessToken;
  String get domain2;
}

class DevConfig implements BaseConfig {
  String get apiHost => "http://45.32.58.54:8500/api/app/";
  String get nameEnv => 'DEV';

  String get domain => 'http://45.32.58.54:8500/';

  String get mapAccessToken =>
      'pk.eyJ1IjoiZGlhZGllbWxrIiwiYSI6ImNsMmgxZGM0cjA5bnIzY21rbnk0NWI4N2oifQ.ZxyP2isXgHTZAwRIJZcGgQ';

  @override
  String get domain2 => 'http://103.130.219.99:8501/';
}

class ProdConfig implements BaseConfig {
  String get apiHost => "http://45.32.58.54:8500/api/app/";
  String get nameEnv => 'PROD';

  String get domain => 'http://45.32.58.54:8500/';
  String get mapAccessToken =>
      'pk.eyJ1IjoiZGlhZGllbWxrIiwiYSI6ImNsMmgxZGM0cjA5bnIzY21rbnk0NWI4N2oifQ.ZxyP2isXgHTZAwRIJZcGgQ';

  @override
  String get domain2 => 'http://103.130.219.99:8501/';
}

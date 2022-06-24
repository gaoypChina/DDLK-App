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
  CategoryStatic get categoryStatic;
}

class DevConfig implements BaseConfig {
  String get apiHost => "http://45.32.58.54:8500/api/app/";
  String get nameEnv => 'DEV';

  String get domain => 'http://45.32.58.54:8500/';

  String get mapAccessToken =>
      'pk.eyJ1IjoiZGlhZGllbWxrIiwiYSI6ImNsMmgxZGM0cjA5bnIzY21rbnk0NWI4N2oifQ.ZxyP2isXgHTZAwRIJZcGgQ';

  @override
  String get domain2 => 'http://103.130.219.99:8501/';

  @override
  CategoryStatic get categoryStatic => CategoryStaticDev();
}

class ProdConfig implements BaseConfig {
  String get apiHost => "http://103.130.219.99:8500/api/app/";
  String get nameEnv => 'PROD';

  String get domain => 'http://103.130.219.99:8500/';
  String get mapAccessToken =>
      'pk.eyJ1IjoiZGlhZGllbWxrIiwiYSI6ImNsMmgxZGM0cjA5bnIzY21rbnk0NWI4N2oifQ.ZxyP2isXgHTZAwRIJZcGgQ';

  @override
  String get domain2 => 'http://103.130.219.99:8500/';

  @override
  CategoryStatic get categoryStatic => CategoryStaticProd();
}

abstract class CategoryStatic {
  String get food;
  String get hotel;
  String get entertainment;
  String get shopping;
  String get travel;
}

class CategoryStaticDev extends CategoryStatic {
  String get food => '6259bcedcab22708e32ee7f7';
  String get hotel => '6259bcf7cab22708e32ee7fe';
  String get entertainment => '625e5afbbd70a52b457f11e1';
  String get shopping => '625e5abdbd70a52b457f11da';
  String get travel => '6261162914b5104a52304237';
}

class CategoryStaticProd extends CategoryStatic {
  String get food => '629c9f6617dd741c0c5b5cf8';
  String get hotel => '629c9fb917dd741c0c5b5d0c';
  String get entertainment => '629c9f8817dd741c0c5b5d00';
  String get shopping => '629c9f7817dd741c0c5b5cfc';
  String get travel => '629c9fac17dd741c0c5b5d08';
}

class Configuration {
  static String _baseUrl = '';

  static String get baseUrl => _baseUrl;

  static setBaseUrl(String url) {
    _baseUrl = url;
  }
}
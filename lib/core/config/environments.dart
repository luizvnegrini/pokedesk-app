class Environments {
  static String get baseUrl => const String.fromEnvironment('API_BASE_URL',
      defaultValue: 'www.pokeapi.co');
}

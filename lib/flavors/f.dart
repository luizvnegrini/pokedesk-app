enum Flavor {
  dev,
  hml,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'pokedesk dev';
      case Flavor.hml:
        return 'pokedesk hml';
      case Flavor.prod:
        return 'pokedesk prod';
      default:
        throw UnimplementedError('Flavor not encountered');
    }
  }
}

import 'package:flutter/material.dart';

import '../../presentation/presentation.dart';

class MainRoutes {
  static String get _source => '/home';
  static String get home => _source;
  static String get pokemonDetails => '$_source/pokemon-details';
}

List<MapEntry<String, Widget Function(BuildContext)>> mainRoutes = [
  MapEntry(
    MainRoutes.home,
    (context) => const HomePage(),
  ),
  MapEntry(
    MainRoutes.pokemonDetails,
    (context) => const PokemonDetailsPage(),
  ),
];

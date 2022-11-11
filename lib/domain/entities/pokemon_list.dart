import 'pokemon_pre_data.dart';

class PokemonList {
  final int count;
  final String next;
  final String? previous;
  final List<PokemonPreData> results;

  PokemonList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
}

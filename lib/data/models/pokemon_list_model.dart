import '../../domain/domain.dart';
import '../data.dart';

class PokemonListModel {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonPreDataModel> results;

  PokemonListModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokemonListModel.fromJson(Map<String, dynamic> json) =>
      PokemonListModel(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: (json['results'] as List)
            .map((result) => PokemonPreDataModel.fromJson(result))
            .toList(),
      );

  PokemonList toEntity() => PokemonList(
        count: count,
        next: next,
        previous: previous,
        results: results.map((e) => e.toEntity()).toList(),
      );
}

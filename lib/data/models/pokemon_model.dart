import '../../domain/domain.dart';
import '../data.dart';

class PokemonModel {
  final String name;
  final num weight;
  final num height;
  final List<StatModel> stats;
  final List<HabilityModel> habilities;

  PokemonModel({
    required this.name,
    required this.weight,
    required this.height,
    required this.habilities,
    required this.stats,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        name: json['name'],
        height: json['height'],
        weight: json['weight'],
        stats: (json['stats'] as List)
            .map((stat) => StatModel.fromJson(stat))
            .toList(),
        habilities: (json['abilities'] as List)
            .map((stat) => HabilityModel.fromJson(stat))
            .toList(),
      );

  Pokemon toEntity() => Pokemon(
        name: name,
        habilities: habilities.map((e) => e.toEntity()).toList(),
        stats: stats.map((e) => e.toEntity()).toList(),
        height: height,
        weight: weight,
      );
}

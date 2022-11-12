import '../domain.dart';

class Pokemon {
  final String name;
  final num weight;
  final num height;
  final List<Stat> stats;
  final List<Hability> habilities;

  Pokemon({
    required this.name,
    required this.weight,
    required this.height,
    required this.habilities,
    required this.stats,
  });
}

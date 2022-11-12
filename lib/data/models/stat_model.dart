import '../../domain/domain.dart';

class StatModel {
  final num baseStat;
  final String name;

  StatModel({
    required this.baseStat,
    required this.name,
  });

  factory StatModel.fromJson(Map<String, dynamic> json) => StatModel(
        name: json['stat']['name'],
        baseStat: json['base_stat'],
      );

  Stat toEntity() => Stat(
        name: name,
        baseStat: baseStat,
      );
}

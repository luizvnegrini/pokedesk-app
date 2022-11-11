import '../../domain/domain.dart';

class PokemonPreDataModel {
  final String name;
  final String url;

  PokemonPreDataModel({
    required this.name,
    required this.url,
  });

  factory PokemonPreDataModel.fromJson(Map<String, dynamic> json) =>
      PokemonPreDataModel(
        name: json['name'],
        url: json['url'],
      );

  PokemonPreData toEntity() => PokemonPreData(
        name: name,
        url: url,
      );
}

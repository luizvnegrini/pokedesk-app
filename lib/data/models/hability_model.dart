import '../../domain/domain.dart';

class HabilityModel {
  final String name;

  HabilityModel({
    required this.name,
  });

  factory HabilityModel.fromJson(Map<String, dynamic> json) => HabilityModel(
        name: json['ability']['name'],
      );

  Hability toEntity() => Hability(
        name: name,
      );
}

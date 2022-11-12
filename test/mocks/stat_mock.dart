import 'package:faker/faker.dart';
import 'package:pokedesk_app/domain/domain.dart';

class StatFactory {
  static Stat makeStat() => Stat(
        name: faker.person.firstName(),
        baseStat: faker.randomGenerator.integer(200),
      );
}

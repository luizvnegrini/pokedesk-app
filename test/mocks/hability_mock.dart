import 'package:faker/faker.dart';
import 'package:pokedesk_app/domain/domain.dart';

class HabilityFactory {
  static Hability makeHability() => Hability(
        name: faker.person.firstName(),
      );
}

import 'package:faker/faker.dart';
import 'package:pokedesk_app/domain/domain.dart';

import 'mocks.dart';

class PokemonFactory {
  static Pokemon makePokemon() => Pokemon(
        weight: faker.randomGenerator.integer(2000),
        height: faker.randomGenerator.integer(2000),
        name: faker.person.firstName(),
        habilities: [
          HabilityFactory.makeHability(),
          HabilityFactory.makeHability(),
          HabilityFactory.makeHability(),
        ],
        stats: [
          StatFactory.makeStat(),
          StatFactory.makeStat(),
          StatFactory.makeStat(),
        ],
      );
}

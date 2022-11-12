import 'package:faker/faker.dart';
import 'package:pokedesk_app/domain/domain.dart';

import 'mocks.dart';

class PokemonListFactory {
  static PokemonList makePokemonList() => PokemonList(
        count: faker.randomGenerator.integer(100),
        next: faker.internet.httpsUrl(),
        previous: faker.internet.httpsUrl(),
        results: [
          PokemonPreDataFactory.makePokemonPreData(),
          PokemonPreDataFactory.makePokemonPreData(),
          PokemonPreDataFactory.makePokemonPreData(),
        ],
      );
}

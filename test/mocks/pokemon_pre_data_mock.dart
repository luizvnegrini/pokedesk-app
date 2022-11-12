import 'package:faker/faker.dart';
import 'package:pokedesk_app/domain/domain.dart';

class PokemonPreDataFactory {
  static PokemonPreData makePokemonPreData() {
    return PokemonPreData(
      name: faker.person.firstName(),
      url: faker.internet.httpsUrl(),
    );
  }
}

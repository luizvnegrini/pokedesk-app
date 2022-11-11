import 'package:pokedesk_app/core/infrastructure/remote_datasource_impl.dart';
import 'package:pokedesk_app/data/datasources/pokemon_datasource.dart';
import 'package:pokedesk_app/data/repositories/repositories.dart';

import '../../domain/domain.dart';
import '../core.dart';

abstract class IDependencies {
  //repositories
  abstract final IPokemonRepository pokemonRepository;

  //usecases
  abstract final IFetchPokemons fetchPokemons;

  //datasources
  abstract final IPokemonDataSource pokemonDataSource;
}

class Dependencies implements IDependencies {
  //repositories
  @override
  final IPokemonRepository pokemonRepository;

  //usecases
  @override
  final IFetchPokemons fetchPokemons;

  //datasources
  @override
  final IPokemonDataSource pokemonDataSource;

  Dependencies({
    required this.fetchPokemons,
    required this.pokemonDataSource,
    required this.pokemonRepository,
  });

  static Dependencies load() {
    final dataSourceAdapter =
        RemoteDataSourceAdapter(baseUrl: Environments.baseUrl);
    final dataSource = PokemonDataSource(dataSourceAdapter);
    final pokemonRepository = PokemonRepository(dataSource);

    return Dependencies(
      fetchPokemons: FetchPokemons(pokemonRepository),
      pokemonDataSource: dataSource,
      pokemonRepository: pokemonRepository,
    );
  }
}

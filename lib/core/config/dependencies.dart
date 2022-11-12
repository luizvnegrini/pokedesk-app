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
  abstract final IFetchPokemonDetails fetchPokemonDetails;

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
  @override
  final IFetchPokemonDetails fetchPokemonDetails;

  //datasources
  @override
  final IPokemonDataSource pokemonDataSource;

  Dependencies({
    required this.fetchPokemons,
    required this.fetchPokemonDetails,
    required this.pokemonDataSource,
    required this.pokemonRepository,
  });

  static Dependencies load() {
    final dataSourceAdapter =
        RemoteDataSourceAdapter(baseUrl: Environments.baseUrl);
    final dataSource = PokemonDataSource(dataSourceAdapter);
    final pokemonRepository = PokemonRepository(dataSource);

    return Dependencies(
      pokemonDataSource: dataSource,
      pokemonRepository: pokemonRepository,
      fetchPokemons: FetchPokemons(pokemonRepository),
      fetchPokemonDetails: FetchPokemonDetails(pokemonRepository),
    );
  }
}

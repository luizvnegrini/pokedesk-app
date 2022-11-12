import '../../core/core.dart';
import '../data.dart';

abstract class IPokemonDataSource {
  Future<PokemonListModel> listPokemons({
    required String limit,
    required String offset,
  });

  Future<PokemonModel> fetchPokemonDetail({
    required String pokemonId,
  });
}

class PokemonDataSource implements IPokemonDataSource {
  final IRemoteDataSourceAdapter dataSource;

  PokemonDataSource(this.dataSource);

  @override
  Future<PokemonListModel> listPokemons({
    required String limit,
    required String offset,
  }) async {
    final response = await dataSource.get(
      endpoint: '/pokemon',
      queryParams: {
        'limit': limit,
        'offset': offset,
      },
    );

    return PokemonListModel.fromJson(response);
  }
  
  @override
  Future<PokemonModel> fetchPokemonDetail({required String pokemonId}) async {
    final response = await dataSource.get(
      endpoint: '/pokemon/$pokemonId',
    );

    return PokemonModel.fromJson(response);
  }
}

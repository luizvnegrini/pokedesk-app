import '../../core/core.dart';
import '../data.dart';

abstract class IPokemonDataSource {
  Future<PokemonListModel> listPokemons({
    required String limit,
    required String offset,
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
}

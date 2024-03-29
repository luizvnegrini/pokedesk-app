
import 'package:dartz/dartz.dart';
import 'package:pokedesk_app/core/core.dart';
import 'package:pokedesk_app/data/datasources/pokemon_datasource.dart';
import 'package:pokedesk_app/domain/entities/pokemon.dart';
import 'package:pokedesk_app/domain/entities/pokemon_list.dart';
import 'package:pokedesk_app/domain/repositories/repositories.dart';

class PokemonRepository implements IPokemonRepository {
  final IPokemonDataSource _dataSource;

  PokemonRepository(this._dataSource);

  @override
  Future<Either<PokemonFailure, PokemonList>> fetchList({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await _dataSource.listPokemons(
        limit: limit.toString(),
        offset: offset.toString(),
      );

      return Right(response.toEntity());
    } catch (e) {
      return Left(PokemonFailure(type: ExceptionType.serverError));
    }
  }

  @override
  Future<Either<PokemonFailure, Pokemon>> fetchPokemonDetails({
    required int pokemonId,
  }) async {
    try {
      final response = await _dataSource.fetchPokemonDetail(
        pokemonId: pokemonId.toString(),
      );

      return Right(response.toEntity());
    } catch (e) {
      return Left(PokemonFailure(type: ExceptionType.serverError));
    }
  }
}

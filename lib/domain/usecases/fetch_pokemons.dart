import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../domain.dart';

abstract class IFetchPokemons {
  Future<Either<PokemonFailure, PokemonList>> call({
    required int limit,
    required int offset,
  });
}

class FetchPokemons implements IFetchPokemons {
  final IPokemonRepository pokemonRepository;

  FetchPokemons(this.pokemonRepository);

  @override
  Future<Either<PokemonFailure, PokemonList>> call({
    required int limit,
    required int offset,
  }) async =>
      await pokemonRepository.fetchList(
        limit: limit,
        offset: offset,
      );
}

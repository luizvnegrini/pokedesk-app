import 'package:dartz/dartz.dart';
import 'package:pokedesk_app/domain/domain.dart';

import '../../core/core.dart';

abstract class IPokemonRepository {
  Future<Either<PokemonFailure, PokemonList>> fetchList({
    required int limit,
    required int offset,
  });

  Future<Either<PokemonFailure, Pokemon>> fetchPokemonDetails({
    required int pokemonId,
  });
}

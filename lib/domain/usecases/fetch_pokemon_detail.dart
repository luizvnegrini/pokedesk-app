import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../domain.dart';

abstract class IFetchPokemonDetails {
  Future<Either<PokemonFailure, Pokemon>> call({
    required int pokemonId,
  });
}

class FetchPokemonDetails implements IFetchPokemonDetails {
  final IPokemonRepository pokemonRepository;

  FetchPokemonDetails(this.pokemonRepository);

  @override
  Future<Either<PokemonFailure, Pokemon>> call({
    required int pokemonId,
  }) async =>
      await pokemonRepository.fetchPokemonDetails(
        pokemonId: pokemonId,
      );
}

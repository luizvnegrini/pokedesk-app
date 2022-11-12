import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/domain.dart';

final fetchPokemons = Provider.autoDispose<IFetchPokemons>((_) {
  throw UnimplementedError('fetchPokemons must be overridden');
});
final fetchPokemonDetails = Provider.autoDispose<IFetchPokemonDetails>((_) {
  throw UnimplementedError('fetchPokemonDetails must be overridden');
});

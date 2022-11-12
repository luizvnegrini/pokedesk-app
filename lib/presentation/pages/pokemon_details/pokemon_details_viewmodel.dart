import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';

final pokemonDetailsViewModel = StateNotifierProvider.family<
    IPokemonDetailsViewModel, IPokemonDetailsState, int>(
  (ref, pokemonPreData) => PokemonDetailsViewModel(
    fetchPokemonDetails: ref.read(fetchPokemonDetails),
    pokemonId: pokemonPreData,
  ),
);

abstract class IPokemonDetailsViewModel
    extends ViewModel<IPokemonDetailsState> {
  IPokemonDetailsViewModel(PokemonDetailsState state) : super(state);

  abstract final IFetchPokemonDetails fetchPokemonDetails;

  abstract final int pokemonId;
  Future<void> getPokemonDetails();
}

class PokemonDetailsViewModel extends IPokemonDetailsViewModel {
  PokemonDetailsViewModel({
    required this.fetchPokemonDetails,
    required this.pokemonId,
  }) : super(PokemonDetailsState.initial());

  @override
  final IFetchPokemonDetails fetchPokemonDetails;

  @override
  final int pokemonId;

  @override
  void initViewModel() {
    super.initViewModel();

    getPokemonDetails();
  }

  @override
  Future<void> getPokemonDetails() async {
    state = state.copyWith(isLoading: true);

    final response = await fetchPokemonDetails(pokemonId: pokemonId);
    final newState = response.fold<IPokemonDetailsState>(
      (failure) =>
          state.copyWith(errorMessage: failure.message ?? 'Try again later'),
      (pokemon) => state.copyWith(pokemon: pokemon),
    );

    state = newState.copyWith(isLoading: false);
  }
}

import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedesk_app/domain/domain.dart';

import '../../presentation.dart';

final homeViewModel =
    StateNotifierProvider.autoDispose<IHomeViewModel, IHomeState>(
  (ref) => HomeViewModel(
    fetchPokemons: ref.read(fetchPokemons),
  ),
);

abstract class IHomeViewModel extends ViewModel<IHomeState> {
  abstract final IFetchPokemons fetchPokemons;

  IHomeViewModel(HomeState state) : super(state);

  Future<void> listPokemons({
    required int offset,
  });
  Future<void> searchPokemon(String? value);
  void closeSearchCard();
  Future<void> fetchNextPage();
}

class HomeViewModel extends IHomeViewModel {
  HomeViewModel({
    required this.fetchPokemons,
  }) : super(HomeState.initial());

  @override
  final IFetchPokemons fetchPokemons;

  @override
  void initViewModel() {
    super.initViewModel();

    listPokemons(offset: 0);
  }

  @override
  Future<void> listPokemons({
    required int offset,
  }) async {
    state = state.copyWith(isLoading: true);

    final response = await fetchPokemons(limit: 151, offset: offset);
    final newState = response.fold<IHomeState>(
      (failure) =>
          state.copyWith(errorMessage: failure.message ?? 'Try again later.'),
      (pokemonsResponse) {
        final pokemons = <PokemonPreData>[];
        if (state.pokemons != null) {
          pokemons.addAll(state.pokemons!.results);
        }
        pokemons.addAll(pokemonsResponse.results);

        return state.copyWith(
          pokemons: PokemonList(
            count: pokemonsResponse.count,
            next: pokemonsResponse.next,
            previous: pokemonsResponse.previous,
            results: pokemons,
          ),
        );
      },
    );

    state = newState.copyWith(isLoading: false);
  }

  @override
  Future<void> fetchNextPage() async {
    if (state.pokemons?.next == null) return;

    state = state.copyWith(isLoadingNextPage: true);

    await listPokemons(offset: state.pokemons!.results.length + 1);

    state = state.copyWith(isLoadingNextPage: false);
  }

  @override
  Future<void> searchPokemon(String? value) async {
    state = state.copyWith(
      searchTimer: Timer(
        const Duration(milliseconds: 500),
        () {
          if (value != null && value.isNotEmpty && value.length >= 3) {
            state = state.copyWith(
              searchedPokemons: List.from(
                state.pokemons!.results.where(
                  (element) => element.name.contains(value),
                ),
              ),
            );
          } else {
            state.searchedPokemons?.clear();
            state = state.copyWith(searchedPokemons: null);
          }
        },
      ),
    );
  }

  @override
  void closeSearchCard() {
    state.searchedPokemons?.clear();
    state = state.copyWith(searchedPokemons: null);
  }
}

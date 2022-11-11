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
    required int limit,
  });
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

    listPokemons(
      offset: 0,
      limit: 151,
    );
  }

  @override
  Future<void> listPokemons({
    required int offset,
    required int limit,
  }) async {
    state = state.copyWith(isLoading: true);

    final response = await fetchPokemons(limit: limit, offset: offset);
    final newState = response.fold<IHomeState>(
      (failure) =>
          state.copyWith(errorMessage: failure.message ?? 'Try again later.'),
      (pokemonsResponse) => state.copyWith(pokemons: pokemonsResponse),
    );

    state = newState.copyWith(isLoading: false);
  }
}

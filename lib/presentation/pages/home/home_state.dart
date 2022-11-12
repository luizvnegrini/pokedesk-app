import 'dart:async';

import '../../../domain/domain.dart';
import '../../presentation.dart';

abstract class IHomeState extends ViewModelState {
  const IHomeState();

  abstract final bool isLoading;
  abstract final String errorMessage;
  abstract final PokemonList? pokemons;
  abstract final Timer? searchTimer;
  abstract final List<PokemonPreData>? searchedPokemons;

  IHomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    PokemonList? pokemons,
    Timer? searchTimer,
    List<PokemonPreData>? searchedPokemons,
  });
}

class HomeState extends IHomeState {
  const HomeState({
    this.isLoading = false,
    this.errorMessage = '',
    this.pokemons,
    this.searchTimer,
    this.searchedPokemons,
  });

  factory HomeState.initial() => const HomeState();

  @override
  final bool isLoading;
  @override
  final String errorMessage;
  @override
  final PokemonList? pokemons;
  @override
  final Timer? searchTimer;
  @override
  final List<PokemonPreData>? searchedPokemons;

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        pokemons,
        searchTimer,
        searchedPokemons,
      ];

  @override
  IHomeState copyWith({
    isLoading,
    errorMessage,
    pokemons,
    searchTimer,
    searchedPokemons,
  }) =>
      HomeState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        pokemons: pokemons ?? this.pokemons,
        searchTimer: searchTimer ?? this.searchTimer,
        searchedPokemons: searchedPokemons ?? this.searchedPokemons,
      );
}

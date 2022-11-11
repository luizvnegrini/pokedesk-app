import '../../../domain/domain.dart';
import '../../presentation.dart';

abstract class IHomeState extends ViewModelState {
  const IHomeState();

  abstract final bool isLoading;
  abstract final String errorMessage;
  abstract final PokemonList? pokemons;

  IHomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    PokemonList? pokemons,
  });
}

class HomeState extends IHomeState {
  const HomeState({
    this.isLoading = false,
    this.errorMessage = '',
    this.pokemons,
  });

  factory HomeState.initial() => const HomeState();

  @override
  final bool isLoading;
  @override
  final String errorMessage;
  @override
  final PokemonList? pokemons;

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        pokemons,
      ];

  @override
  IHomeState copyWith({
    isLoading,
    errorMessage,
    pokemons,
  }) =>
      HomeState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        pokemons: pokemons ?? this.pokemons,
      );
}

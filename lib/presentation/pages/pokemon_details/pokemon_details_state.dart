import '../../../domain/domain.dart';
import '../../presentation.dart';

abstract class IPokemonDetailsState extends ViewModelState {
  const IPokemonDetailsState();

  abstract final bool isLoading;
  abstract final String errorMessage;
  abstract final Pokemon? pokemon;

  IPokemonDetailsState copyWith({
    bool? isLoading,
    String? errorMessage,
    Pokemon? pokemon,
  });
}

class PokemonDetailsState extends IPokemonDetailsState {
  const PokemonDetailsState({
    this.isLoading = false,
    this.errorMessage = '',
    this.pokemon,
  });

  factory PokemonDetailsState.initial() => const PokemonDetailsState();

  @override
  final bool isLoading;
  @override
  final String errorMessage;
  @override
  final Pokemon? pokemon;

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        pokemon,
      ];

  @override
  IPokemonDetailsState copyWith({
    isLoading,
    errorMessage,
    pokemon,
  }) =>
      PokemonDetailsState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        pokemon: pokemon ?? this.pokemon,
      );
}

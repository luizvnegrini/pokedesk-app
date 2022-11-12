//vm's
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation.dart';

//vm's
IPokemonDetailsViewModel readPokemonDetailsViewModel(
        WidgetRef ref, int pokemonId) =>
    ref.read(pokemonDetailsViewModel(pokemonId).notifier);

//states
IPokemonDetailsState usePokemonDetailsState(WidgetRef ref, int pokemonId) =>
    ref.watch(pokemonDetailsViewModel(pokemonId));

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../../presentation.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = readHomeViewModel(ref);

    return ScaffoldWidget(
      appBar: AppBar(
        title: const Text('Pokemon list'),
      ),
      body: SafeArea(
        child: HookConsumer(
          builder: (context, ref, child) {
            final state = useHomeState(ref);

            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage.isNotEmpty) {
              return handleError(context, state, viewModel);
            }

            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final pokemon = state.pokemons!.results[index];
                final splitted = pokemon.url.split('/');
                final pokemonId = int.parse(splitted[splitted.length - 2]);

                return Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(width: 30),
                    Text(pokemon.name.toCapitalized(allWords: true)),
                  ],
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: state.pokemons!.results.length,
            );
          },
        ),
      ),
    );
  }

  ElevatedButton handleError(
      BuildContext context, IHomeState state, IHomeViewModel viewModel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          state.errorMessage,
        ),
      ),
    );

    return ElevatedButton(
      onPressed: () => viewModel.fetchPokemons(
        limit: 151,
        offset: 0,
      ),
      child: const Text('Try again'),
    );
  }
}

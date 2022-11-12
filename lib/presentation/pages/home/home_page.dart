import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
        backgroundColor: Colors.red,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'Pokemon list',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: HookConsumer(
          builder: (context, ref, child) {
            final state = useHomeState(ref);

            if (state.isLoading && !state.isLoadingNextPage) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage.isNotEmpty) {
              return handleError(context, state, viewModel);
            }

            final scrollController = useScrollController();
            scrollController.addListener(
              () {
                if (scrollController.offset ==
                        scrollController.position.maxScrollExtent &&
                    !scrollController.position.outOfRange &&
                    !state.isLoadingNextPage &&
                    !state.isLoading) {
                  viewModel.fetchNextPage();
                }
              },
            );
            final searchController = useTextEditingController();

            return Stack(
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      onChanged: viewModel.searchPokemon,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        hintText: 'Search',
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final pokemon = state.pokemons!.results[index];
                          final splitted = pokemon.url.split('/');
                          final pokemonId =
                              int.parse(splitted[splitted.length - 2]);

                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => Navigator.pushNamed(
                              context,
                              MainRoutes.pokemonDetails,
                              arguments: PokemonDetailsPageArguments(
                                pokemonName: pokemon.name,
                                pokemonId: pokemonId,
                              ),
                            ),
                            child: Row(
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
                                Text(
                                    pokemon.name.toCapitalized(allWords: true)),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: state.pokemons!.results.length,
                      ),
                    ),
                    Visibility(
                      visible: state.isLoadingNextPage,
                      child: const CircularProgressIndicator(),
                    ),
                  ],
                ),
                Visibility(
                  visible: state.searchedPokemons != null &&
                      state.searchedPokemons!.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55),
                    child: Card(
                      elevation: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    viewModel.closeSearchCard();
                                    searchController.clear();
                                  },
                                  child: const Icon(Icons.close),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final pokemon = state.searchedPokemons![index];
                                final splitted = pokemon.url.split('/');
                                final pokemonId =
                                    int.parse(splitted[splitted.length - 2]);

                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    MainRoutes.pokemonDetails,
                                    arguments: PokemonDetailsPageArguments(
                                      pokemonName: pokemon.name,
                                      pokemonId: pokemonId,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        width: 40,
                                        height: 40,
                                        imageUrl:
                                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png',
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(pokemon.name.toCapitalized()),
                                      const Spacer(),
                                      const Icon(Icons.navigate_next),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: state.searchedPokemons != null
                                  ? state.searchedPokemons!.length
                                  : 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
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

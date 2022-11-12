import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedesk_app/core/core.dart';

import '../../presentation.dart';

class PokemonDetailsPageArguments {
  final int pokemonId;
  final String pokemonName;
  PokemonDetailsPageArguments({
    required this.pokemonId,
    required this.pokemonName,
  });
}

class PokemonDetailsPage extends HookConsumerWidget {
  const PokemonDetailsPage({Key? key}) : super(key: key);

  TextStyle get boldStyle => const TextStyle(fontWeight: FontWeight.bold);
  EdgeInsets get defaultContentPadding => const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments
        as PokemonDetailsPageArguments;
    final viewModel = readPokemonDetailsViewModel(ref, args.pokemonId);

    return ScaffoldWidget(
      appBar: AppBar(title: const Text('Pokemon details')),
      body: SafeArea(
        child: HookConsumer(
          builder: (context, ref, child) {
            final state = usePokemonDetailsState(ref, args.pokemonId);

            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage.isNotEmpty) {
              return handleError(context, state, viewModel);
            }

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Padding(
                        padding: defaultContentPadding,
                        child: Text(
                          args.pokemonName.toCapitalized(allWords: true),
                          style: boldStyle.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl:
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${args.pokemonId}.png',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(height: 50),
                    Card(
                      child: Padding(
                        padding: defaultContentPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Height:',
                                  style: boldStyle,
                                ),
                                Text(
                                  state.pokemon!.height.toString(),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Weight:',
                                  style: boldStyle,
                                ),
                                Text(
                                  state.pokemon!.weight.toString(),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: defaultContentPadding,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Stats',
                                  style: boldStyle,
                                ),
                                Text(
                                  'Habilities',
                                  style: boldStyle,
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final stat =
                                            state.pokemon!.stats[index];

                                        return Row(
                                          children: [
                                            Text(
                                              '${stat.name.toCapitalized(allWords: true)}: ',
                                              style: boldStyle,
                                            ),
                                            Text(
                                              stat.baseStat.toString(),
                                            )
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 14,
                                          ),
                                      itemCount: state.pokemon!.stats.length),
                                ),
                                Expanded(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final hability =
                                            state.pokemon!.habilities[index];

                                        return Text(
                                          hability.name
                                              .toCapitalized(allWords: true),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 14,
                                          ),
                                      itemCount:
                                          state.pokemon!.habilities.length),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ElevatedButton handleError(BuildContext context, IPokemonDetailsState state,
      IPokemonDetailsViewModel viewModel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          state.errorMessage,
        ),
      ),
    );

    return ElevatedButton(
      onPressed: viewModel.getPokemonDetails,
      child: const Text('Try again'),
    );
  }
}

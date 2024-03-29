import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedesk_app/presentation/presentation.dart';

import 'app_state.dart';
import 'app_viewmodel.dart';
import 'core/core.dart';
import 'flavors/flavors.dart';
import 'utils/utils.dart';

class Startup {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    final vm = AppViewModel();
    vm.loadDependencies();

    runApp(_App(viewModel: vm));
  }
}

class _App extends StatelessWidget {
  final AppViewModel viewModel;
  String get appTitle => 'Pokedesk';

  const _App({
    required this.viewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<AsyncValue<IAppState>>(
        valueListenable: viewModel,
        builder: (context, value, child) => value.maybeWhen(
          data: (state) => ProviderScope(
            overrides: [
              fetchPokemons.overrideWithValue(state.dependencies.fetchPokemons),
              fetchPokemonDetails
                  .overrideWithValue(state.dependencies.fetchPokemonDetails),
            ],
            child: const AppLoadedRoot(),
          ),
          orElse: () => MaterialApp(
            title: appTitle,
            theme: ThemeData(
              primarySwatch: Colors.orange,
              useMaterial3: true,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: _flavorBanner(
              child: Scaffold(
                body: Container(
                  alignment: Alignment.center,
                  color: Colors.orange,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Loading dependencies...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              show: kDebugMode,
            ),
          ),
        ),
      );
}

Widget _flavorBanner({
  required Widget child,
  bool show = true,
}) =>
    show
        ? Banner(
            location: BannerLocation.topStart,
            message: F.name,
            color: Colors.green.withOpacity(0.6),
            textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0),
            textDirection: TextDirection.ltr,
            child: child,
          )
        : Container(
            child: child,
          );

class AppLoadedRoot extends HookConsumerWidget {
  const AppLoadedRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
        title: 'Pokedesk',
        theme: ThemeData(
          primarySwatch: Colors.red,
          useMaterial3: true,
        ),
        initialRoute: MainRoutes.home,
        routes: <String, Widget Function(BuildContext)>{}..addEntries(
            [
              ...mainRoutes,
            ],
          ),
        scaffoldMessengerKey: useScaffoldMessenger(ref),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
      );
}

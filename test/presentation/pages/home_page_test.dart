import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedesk_app/core/core.dart';
import 'package:pokedesk_app/domain/domain.dart';
import 'package:pokedesk_app/presentation/presentation.dart';

import '../../mocks/mocks.dart';
import '../widget_testable.dart';

class IFetchPokemonsMock extends Mock implements IFetchPokemons {}

void main() {
  final fetchPokemonsSpy = IFetchPokemonsMock();

  final defaultTestWidget = WidgetTestable.builder()
      .override(
        providers: [
          fetchPokemons.overrideWithValue(fetchPokemonsSpy),
        ],
      )
      .addPage(const HomePage())
      .build();

  Future<void> waitForPageInitialization(
      WidgetTester tester, Widget defaultTestWidget) async {
    await tester.pumpWidget(defaultTestWidget);
    await tester.pump();
  }

  setUpAll(() {
    when(() => fetchPokemonsSpy(limit: 151, offset: 0)).thenAnswer(
      (invocation) async => Future.value(
        Right(PokemonListFactory.makePokemonList()),
      ),
    );
  });

  testWidgets('Should open with circular progress indicator', (tester) async {
    await tester.pumpWidget(defaultTestWidget);

    final circularProgressIndicator = find.byType(CircularProgressIndicator);
    expect(circularProgressIndicator, findsOneWidget);
  });

  testWidgets('Should find search TextFormField', (tester) async {
    await waitForPageInitialization(tester, defaultTestWidget);

    final textFormField = find.byType(TextFormField);

    expect(textFormField, findsOneWidget);
  });

  testWidgets('Should find list of pokemons', (tester) async {
    await waitForPageInitialization(tester, defaultTestWidget);

    final list = find.byType(ListView);

    expect(list, findsOneWidget);
  });

  testWidgets('Should find try again button', (tester) async {
    when(() => fetchPokemonsSpy(limit: 151, offset: 0)).thenAnswer(
        (invocation) async => Future.value(
            Left(PokemonFailure(type: ExceptionType.serverError))));
    await waitForPageInitialization(tester, defaultTestWidget);

    final buttonText = find.text('Try again');

    expect(buttonText, findsOneWidget);
  });
}

import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedesk_app/core/core.dart';
import 'package:pokedesk_app/domain/domain.dart';

import '../../mocks/mocks.dart';

class IPokemonRepositoryMock extends Mock implements IPokemonRepository {}

void main() {
  late IFetchPokemonDetails sut;
  late IPokemonRepositoryMock spy;

  setUp(() {
    spy = IPokemonRepositoryMock();
    sut = FetchPokemonDetails(spy);
  });

  test(
      'should call repository method using correct pokemonId and return correct response',
      () async {
    final pokemonId = faker.randomGenerator.integer(1500);
    final pokemon = PokemonFactory.makePokemon();

    when(() => spy.fetchPokemonDetails(pokemonId: pokemonId)).thenAnswer(
      (invocation) async => Right(
        pokemon,
      ),
    );

    final response = await sut(pokemonId: pokemonId);

    verify(() => spy.fetchPokemonDetails(pokemonId: pokemonId));
    expect(Right(pokemon), response);
  });

  test('should call return Left with PokemonFailure', () async {
    final pokemonId = faker.randomGenerator.integer(100);

    when(() => spy.fetchPokemonDetails(pokemonId: pokemonId)).thenAnswer(
      (invocation) async =>
          Left(PokemonFailure(type: ExceptionType.serverError)),
    );

    final response = await sut(pokemonId: pokemonId);

    expect(Left(PokemonFailure(type: ExceptionType.serverError)), response);
  });
}

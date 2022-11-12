import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedesk_app/core/core.dart';
import 'package:pokedesk_app/domain/domain.dart';

import '../../mocks/mocks.dart';

class IPokemonRepositoryMock extends Mock implements IPokemonRepository {}

void main() {
  late IFetchPokemons sut;
  late IPokemonRepositoryMock spy;

  setUp(() {
    spy = IPokemonRepositoryMock();
    sut = FetchPokemons(spy);
  });

  test(
      'should call repository method using correct parameters and return right response',
      () async {
    const limit = 151;
    const offset = 0;

    final pokemonList = PokemonListFactory.makePokemonList();

    when(() => spy.fetchList(limit: limit, offset: offset)).thenAnswer(
      (invocation) async => Right(pokemonList),
    );

    final response = await sut(limit: limit, offset: offset);

    verify(() => spy.fetchList(limit: limit, offset: offset));
    expect(Right(pokemonList), response);
  });

  test('should call return Left with PokemonFailure', () async {
    const limit = 151;
    const offset = 0;

    when(() => spy.fetchList(limit: limit, offset: offset)).thenAnswer(
      (invocation) async =>
          Left(PokemonFailure(type: ExceptionType.serverError)),
    );

    final response = await sut(limit: limit, offset: offset);

    expect(Left(PokemonFailure(type: ExceptionType.serverError)), response);
  });
}

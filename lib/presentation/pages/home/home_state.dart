import '../../presentation.dart';

abstract class IHomeState extends ViewModelState {
  const IHomeState();

  IHomeState copyWith();
}

class HomeState extends IHomeState {
  const HomeState();

  factory HomeState.initial() => const HomeState();

  @override
  List<Object?> get props => [];

  @override
  IHomeState copyWith() => const HomeState();
}

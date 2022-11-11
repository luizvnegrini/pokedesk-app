import 'core/core.dart';

abstract class IAppState {
  abstract final IDependencies dependencies;
}

class AppState extends IAppState {
  AppState({
    required this.dependencies,
  });

  @override
  final IDependencies dependencies;
}

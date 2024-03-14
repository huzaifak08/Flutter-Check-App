import 'package:get_it/get_it.dart';
import 'package:test_app/mobx/switch/switch_store.dart';
import 'package:test_app/repository/switch_repo.dart';

final getIt = GetIt.instance;

Future<void> setUpLocator() async {
  // Register Repositories:
  getIt.registerSingleton<SwitchRepository>(SwitchRepository());

  // Register Stores with Repositories:
  getIt.registerSingleton<SwitchStore>(SwitchStore());
}

import "package:mobx/mobx.dart";
part 'counter_store.g.dart';

// ignore: library_private_types_in_public_api
class CounterStore = _CounterStore with _$CounterStore;

// Add mobx, flutter_mobx and build_runner in dependencies and dev-dependencies
// Run this Command: flutter pub run build_runner watch --delete-conflicting-outputs

abstract class _CounterStore with Store {
  @observable
  int count = 0;

  @action
  void increment() {
    count++;
  }

  @action
  void decrement() {
    count--;
  }
}

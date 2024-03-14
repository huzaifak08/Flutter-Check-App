import 'package:mobx/mobx.dart';
part 'switch_store.g.dart';

// ignore: library_private_types_in_public_api
class SwitchStore = _SwitchStore with _$SwitchStore;

abstract class _SwitchStore with Store {
  @observable
  bool isSwitch = false;

  @action
  void toggleSwitch() {
    isSwitch = !isSwitch;
  }

  // General -------------------------------------------------------------------
  void init() {}
}

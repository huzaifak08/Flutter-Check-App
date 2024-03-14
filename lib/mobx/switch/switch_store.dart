import 'package:mobx/mobx.dart';
import 'package:test_app/repository/switch_repo.dart';
part 'switch_store.g.dart';

// ignore: library_private_types_in_public_api
class SwitchStore = _SwitchStore with _$SwitchStore;

abstract class _SwitchStore with Store {
  final SwitchRepository _switchRepo = SwitchRepository();

  @observable
  bool _isSwitch = false;

  @computed
  bool get isSwitch => _isSwitch;

  @action
  void toggleSwitch(bool value) {
    _switchRepo.toggleSwitch(value);
    _isSwitch = value;
  }

  // General -------------------------------------------------------------------
  void init() {}
}

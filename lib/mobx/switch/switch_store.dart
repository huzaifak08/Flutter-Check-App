import 'package:mobx/mobx.dart';
import 'package:test_app/repository/switch_repo.dart';
part 'switch_store.g.dart';

// ignore: library_private_types_in_public_api
class SwitchStore = _SwitchStore with _$SwitchStore;

// Add mobx, flutter_mobx and build_runner in dependencies and dev-dependencies
// Run this Command: flutter pub run build_runner watch --delete-conflicting-outputs

abstract class _SwitchStore with Store {
  final SwitchRepository _switchRepo = SwitchRepository();

  @observable
  bool _isSwitch = false;

  @computed
  bool get isSwitch => _isSwitch;

  @observable
  double _slider = 0.0;

  @computed
  double get slider => _slider;

  @action
  void toggleSwitch(bool value) {
    _switchRepo.toggleSwitch(value);
    _isSwitch = value;
  }

  @action
  void moveSlider(double value) {
    _slider = value;
  }

  // General -------------------------------------------------------------------
  void init() {}
}

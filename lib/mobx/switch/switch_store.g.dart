// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SwitchStore on _SwitchStore, Store {
  Computed<bool>? _$isSwitchComputed;

  @override
  bool get isSwitch => (_$isSwitchComputed ??=
          Computed<bool>(() => super.isSwitch, name: '_SwitchStore.isSwitch'))
      .value;

  late final _$_isSwitchAtom =
      Atom(name: '_SwitchStore._isSwitch', context: context);

  @override
  bool get _isSwitch {
    _$_isSwitchAtom.reportRead();
    return super._isSwitch;
  }

  @override
  set _isSwitch(bool value) {
    _$_isSwitchAtom.reportWrite(value, super._isSwitch, () {
      super._isSwitch = value;
    });
  }

  late final _$_SwitchStoreActionController =
      ActionController(name: '_SwitchStore', context: context);

  @override
  void toggleSwitch(bool value) {
    final _$actionInfo = _$_SwitchStoreActionController.startAction(
        name: '_SwitchStore.toggleSwitch');
    try {
      return super.toggleSwitch(value);
    } finally {
      _$_SwitchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSwitch: ${isSwitch}
    ''';
  }
}
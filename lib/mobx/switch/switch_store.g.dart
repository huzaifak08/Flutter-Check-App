// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SwitchStore on _SwitchStore, Store {
  late final _$isSwitchAtom =
      Atom(name: '_SwitchStore.isSwitch', context: context);

  @override
  bool get isSwitch {
    _$isSwitchAtom.reportRead();
    return super.isSwitch;
  }

  @override
  set isSwitch(bool value) {
    _$isSwitchAtom.reportWrite(value, super.isSwitch, () {
      super.isSwitch = value;
    });
  }

  late final _$_SwitchStoreActionController =
      ActionController(name: '_SwitchStore', context: context);

  @override
  void toggleSwitch() {
    final _$actionInfo = _$_SwitchStoreActionController.startAction(
        name: '_SwitchStore.toggleSwitch');
    try {
      return super.toggleSwitch();
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

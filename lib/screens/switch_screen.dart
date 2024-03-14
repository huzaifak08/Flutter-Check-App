import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:test_app/components/service_locator.dart';
import 'package:test_app/mobx/switch/switch_store.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  final SwitchStore _switchStore = getIt<SwitchStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch Screen'),
      ),
      body: Center(
        child: Observer(
          builder: (context) {
            return Column(
              children: [
                Switch(
                  value: _switchStore.isSwitch,
                  onChanged: (value) {
                    _switchStore.toggleSwitch(value);
                  },
                ),
                const SizedBox(height: 23),
                Slider(
                  value: _switchStore.slider,
                  onChanged: (value) {
                    _switchStore.moveSlider(value);
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

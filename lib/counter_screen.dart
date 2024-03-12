import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:test_app/mobx/counter_store.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final CounterStore counterStore = CounterStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Using Mobx')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Observer(
              builder: (context) => Text(counterStore.count.toString()),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => counterStore.increment(),
              child: const Text('Increment'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => counterStore.decrement(),
              child: const Text('Decrement'),
            )
          ],
        ),
      ),
    );
  }
}

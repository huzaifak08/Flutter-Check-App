import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Providers/count_provider.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Screen'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CountProvider(),
        child: Consumer<CountProvider>(
          builder: (context, provider, child) {
            return Center(
              child: Column(
                children: [
                  Text(
                    provider.count.toString(),
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            provider.incrementCounter();
                          },
                          child: Text('Increment')),
                      ElevatedButton(
                          onPressed: () {
                            provider.decrementCounter();
                          },
                          child: Text('Decrement'))
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

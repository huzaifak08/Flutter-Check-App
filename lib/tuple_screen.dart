import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class TupleScreen extends StatefulWidget {
  const TupleScreen({super.key});

  @override
  State<TupleScreen> createState() => _TupleScreenState();
}

class _TupleScreenState extends State<TupleScreen> {
  // Check Tuple Method

  Tuple2<int?, String?> checkTuple(int num) {
    if (num > 100) {
      return const Tuple2(null, 'The number is greater than 100');
    } else {
      return Tuple2(num, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Tuple2<int?, String?> ourNum = checkTuple(101);

            debugPrint('Item 1: ${ourNum.item1}, Item 2: ${ourNum.item2}');
          },
          child: const Text('Check Button'),
        ),
      ),
    );
  }
}

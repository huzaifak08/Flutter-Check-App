import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Use key if you want to trigger tooltip from another onClick (floating button)

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Tooltip(
          key: tooltipkey, // only in case of manual trigger (Floating Button)
          triggerMode: TooltipTriggerMode.manual, //in case of manual trigger
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [Colors.amber, Colors.red],
            ),
          ),
          height: 50,
          waitDuration: const Duration(seconds: 2),
          message: "Add this",
          child: const Icon(Icons.add, size: 50),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tooltipkey.currentState?.ensureTooltipVisible();
        },
      ),
    );
  }
}

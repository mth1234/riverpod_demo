import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final counterProvider =
    StateNotifierProvider<CounterModel, int>((ref) => CounterModel(0));

class CounterModel extends StateNotifier<int> {
  CounterModel(int initialNumber) : super(initialNumber);

  void inc() {
    state++;
  }
}

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final int count = useProvider(counterProvider);

    return Scaffold(
      body: Center(
        child: Text('$count'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          context.read(counterProvider.notifier).inc();
        },
      ),
    );
  }
}

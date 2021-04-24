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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$count'),
            ElevatedButton(
              onPressed: () async {
                var result = await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('画像'),
                                Icon(Icons.image),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('文章'),
                                Icon(Icons.add),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('show'),
            ),
          ],
        ),
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

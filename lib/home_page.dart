import 'package:flutter/material.dart';
import 'package:wstore/wstore.dart';

class HomePageStore extends WStore {
  int counter = 0;

  void incrementCounter() {
    setStore(() {
      counter++;
    });
  }

  @override
  HomePage get widget => super.widget as HomePage;
}

class HomePage extends WStoreWidget<HomePageStore> {
  const HomePage({
    super.key,
  });

  @override
  HomePageStore createWStore() => HomePageStore();

  @override
  Widget build(BuildContext context, HomePageStore store) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            WStoreValueBuilder<HomePageStore, int>(
              watch: (store) => store.counter,
              builder: (context, counter) {
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: store.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

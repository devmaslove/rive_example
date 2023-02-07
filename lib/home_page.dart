import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
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
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: Color(0xFF40495E),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            children: const [
              SizedBox(
                height: 36,
                width: 36,
                child: RiveAnimation.asset(
                  'assets/rive/icons.riv',
                  artboard: 'LIKE/STAR',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

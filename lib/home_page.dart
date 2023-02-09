import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:wstore/wstore.dart';

class RiveButton {
  final String title;
  final String artboard;
  final String stateMachineName;
  SMIBool? input;
  bool selected;

  RiveButton({
    required this.title,
    required this.artboard,
    required this.stateMachineName,
    this.selected = false,
  });
}

class HomePageStore extends WStore {
  int counter = 0;

  final buttons = [
    RiveButton(
      title: 'Чат',
      stateMachineName: 'CHAT_Interactivity',
      artboard: 'CHAT',
      selected: true,
    ),
    RiveButton(
      title: 'Поиск',
      stateMachineName: 'SEARCH_Interactivity',
      artboard: 'SEARCH',
    ),
    RiveButton(
      title: 'Таймер',
      stateMachineName: 'TIMER_Interactivity',
      artboard: 'TIMER',
    ),
    RiveButton(
      title: 'Звонок',
      stateMachineName: 'BELL_Interactivity',
      artboard: 'BELL',
    ),
    RiveButton(
      title: 'Пользователь',
      stateMachineName: 'USER_Interactivity',
      artboard: 'USER',
    ),
  ];

  void setSelected(RiveButton button) {
    setStore(() {
      button.selected = true;
      buttons
          .where((btn) => btn != button)
          .forEach((btn) => btn.selected = false);
    });
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...store.buttons.map(
                (button) => WStoreValueBuilder<HomePageStore, bool>(
                  watch: (store) => button.selected,
                  store: store,
                  builder: (context, selected) {
                    return GestureDetector(
                      onTap: () {
                        button.input?.change(true);
                        Future.delayed(
                          const Duration(
                            milliseconds: 100,
                          ),
                          () => button.input?.change(false),
                        );
                        store.setSelected(button);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(2),
                            height: 4,
                            width: selected ? 20 : 0,
                            decoration: const BoxDecoration(
                              color: Color(0xFF81B4FF),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 36,
                            width: 36,
                            child: Opacity(
                              opacity: selected ? 1 : 0.5,
                              child: RiveAnimation.asset(
                                'assets/rive/icons.riv',
                                artboard: button.artboard,
                                stateMachines: [button.stateMachineName],
                                onInit: (artboard) {
                                  for (var controller
                                      in artboard.animationControllers) {
                                    if (controller is StateMachineController &&
                                        controller.stateMachine.name ==
                                            button.stateMachineName) {
                                      button.input =
                                          controller.findSMI<SMIBool>('active');
                                    }
                                  }
                                  assert(
                                    button.input != null,
                                    'Can\'t find state machine ${button.stateMachineName}',
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:wstore/wstore.dart';

class OnbodingScreenStore extends WStore {
  // TODO: add data here...

  @override
  OnbodingScreen get widget => super.widget as OnbodingScreen;
}

class OnbodingScreen extends WStoreWidget<OnbodingScreenStore> {
  const OnbodingScreen({
    super.key,
  });

  @override
  OnbodingScreenStore createWStore() => OnbodingScreenStore();

  @override
  Widget build(BuildContext context, OnbodingScreenStore store) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 100,
            bottom: 200,
            width: MediaQuery.of(context).size.width * 1.7,
            child: Image.asset('assets/images/Spline.png'),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            'assets/rive/shapes.riv',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  SizedBox(
                    width: 280,
                    child: Column(
                      children: const [
                        Text(
                          'Rive example',
                          style: TextStyle(
                            fontSize: 60,
                            height: 1.2,
                            fontFamily: 'Poppins'
                          ),
                        ),
                        SizedBox(height: 16),
                        Text('Делаю приложение для демострации возможностей анимации rive на flutter'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_example/screens/onboding/components/custom_sign_in_dialog.dart';
import 'package:wstore/wstore.dart';

class OnbodingScreenStore extends WStore {
  bool isSignInDialogShown = false;

  void setSignInDialogShown(bool show) {
    setStore(() {
      isSignInDialogShown = show;
    });
  }

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
      body: AnimatedBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              SizedBox(
                width: 280,
                child: Column(
                  children: const [
                    Text(
                      'Rive example',
                      style: TextStyle(
                        fontSize: 60,
                        height: 1.2,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Делаю приложение для демонстрации возможностей анимации rive на flutter',
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              AnimationStartButton(
                onPress: () {
                  store.setSignInDialogShown(true);
                  customSignInDialog(context).then(
                    (value) {
                      store.setSignInDialogShown(false);
                    },
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Мотивирующий текст, для того чтобы уж точно нажать на эту кнопку. Жми!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        WStoreValueBuilder<OnbodingScreenStore, bool>(
          watch: (store) => store.isSignInDialogShown,
          builder: (context, show) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 240),
              top: show ? -50 : 0,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: child,
              ),
            );
          },
        ),
      ],
    );
  }
}

class AnimationStartButton extends StatefulWidget {
  final VoidCallback onPress;

  const AnimationStartButton({
    super.key,
    required this.onPress,
  });

  @override
  State<AnimationStartButton> createState() => _AnimationStartButtonState();
}

class _AnimationStartButtonState extends State<AnimationStartButton> {
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      'active',
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _btnAnimationController.isActive = true;
        Future.delayed(
          const Duration(milliseconds: 800),
          () {
            widget.onPress();
          },
        );
      },
      child: SizedBox(
        height: 64,
        width: 260,
        child: Stack(
          children: [
            RiveAnimation.asset(
              'assets/rive/button.riv',
              controllers: [_btnAnimationController],
            ),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(CupertinoIcons.arrow_right),
                  SizedBox(width: 8),
                  Text(
                    'Погнали',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

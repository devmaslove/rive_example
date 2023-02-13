import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive_example/screens/onboding/components/sign_in_form.dart';

Future<Object?> customSignInDialog(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Sign In',
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, ___, child) {
      Tween<Offset> tween;
      tween = Tween(
        begin: const Offset(0, -1),
        end: Offset.zero,
      );
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Center(
      child: Container(
        height: 568,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  const SizedBox(width: double.infinity),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 34,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Большой поясняющий текст, в котором говорится о том почему надо входить.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const SignInForm(),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sign in with Email, Apple or Google',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          'assets/icons/email_box.svg',
                          height: 64,
                          width: 64,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          'assets/icons/apple_box.svg',
                          height: 64,
                          width: 64,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          'assets/icons/google_box.svg',
                          height: 64,
                          width: 64,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: -48,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

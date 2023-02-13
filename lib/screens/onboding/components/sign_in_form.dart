import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset('assets/icons/email.svg'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Password',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 8),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset('assets/icons/password.svg'),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF77D8E),
              minimumSize: const Size(double.infinity, 56),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
            ),
            icon: const Icon(
              CupertinoIcons.arrow_right,
              color: Color(0xFFFE0037),
            ),
            label: const Text('Sign In'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

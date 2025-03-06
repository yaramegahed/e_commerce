import 'package:flutter/material.dart';

import '../../register/register_screen.dart';

class SignupRow extends StatelessWidget {
  const SignupRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Do not have an account?",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ));
            },
            child: const Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15),
            )),
      ],
    );
  }
}

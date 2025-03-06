import 'package:flutter/material.dart';

import '../../fordet_password/forget_password.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgetPassword(),
              ));
        },
        child: Text(
          "forget password",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16),
        ));
  }
}

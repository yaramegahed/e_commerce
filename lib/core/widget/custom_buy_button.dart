import 'package:flutter/material.dart';

class CustomBuyButton extends StatelessWidget {
  const CustomBuyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue),
      child: Center(
          child: Text(
            "Buy now",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}

import 'package:flutter/material.dart';

class CustomButtonProfile extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final IconData icon;
  const CustomButtonProfile({super.key, required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextButton(
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)))),
          backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon,color: Colors.white,size: 28,),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 25,)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final Color? color;
  final IconData? suffixIcon;
  final String label;
  final String hint;
  final bool? obscureText;
  final void Function()? onTap;

  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.label,
    required this.hint,
    this.obscureText,
    this.onTap,
    this.color,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      style: const TextStyle(fontWeight: FontWeight.bold),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            prefixIcon,
            color: Colors.indigo,
          ),
        ),
        suffix: InkWell(
            onTap: onTap,
            child: Icon(
              suffixIcon,
              size: 25,
              color: color,
            )),
        label: Text(label),
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: border(color: Colors.indigo, ),
        focusedBorder: border(color: Colors.red, ),
      ),
    );
  }

  InputBorder border({required color, }) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: color,width: 1.5));
  }
}

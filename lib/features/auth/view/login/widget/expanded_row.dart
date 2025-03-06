import 'package:flutter/material.dart';

class ExpandedRow extends StatelessWidget {
  const ExpandedRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 2,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          "Or ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Divider(
            thickness: 2,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.indigo, width: 2)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          decoration: InputDecoration(
              hintText: "search",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold, height: 2, color: Colors.grey),
              suffixIcon: Container(
                  width: 70,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue.shade900,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueAccent),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 27,
                    ),
                    color: Colors.white,
                  )),
              border: InputBorder.none),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

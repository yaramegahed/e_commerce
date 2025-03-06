import 'package:flutter/cupertino.dart';

class GoogleContainer extends StatelessWidget {
  const GoogleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 2, color: CupertinoColors.inactiveGray)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              height: 30,
              "assets/images/OIP.jpeg",
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Login with google",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}

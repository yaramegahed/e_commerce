import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Text(
              "User Name",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              width: 10,
            ),
            Text("comment"),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 5,
        );
      },
      itemCount: 10,
    );
  }
}

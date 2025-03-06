import 'package:e_commerce/core/widget/custom_app_bar.dart';
import 'package:e_commerce/core/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          children: [
            CustomTextField(
              controller: controller,
              hint: 'name',
              prefixIcon: Icons.person,
              suffixIcon: Icons.check,
              onTap: () {
                controller.clear();
              },
              color: Colors.green,
              label: 'Edit name',
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_uber_eats/commons/components/custom_text_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: 'Email',
              onChanged: (String value) {},
            ),
            CustomTextFormField(
              hintText: 'Password',
              onChanged: (String value) {},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vlab1/action_box.dart';
import 'package:vlab1/buttons_column.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ActionBox(),
              SizedBox(
                width: 20,
              ),
              ButtonsColumn(),
            ],
          ),
        ),
      ),
    );
  }
}

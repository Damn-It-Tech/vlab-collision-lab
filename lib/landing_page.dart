import 'package:flutter/material.dart';
import 'package:vlab1/action_box.dart';
import 'package:vlab1/buttons_row.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ButtonsRow(),
              SizedBox(
                height: 20,
              ),
              ActionBox(),
            ],
          ),
        ),
      ),
    );
  }
}

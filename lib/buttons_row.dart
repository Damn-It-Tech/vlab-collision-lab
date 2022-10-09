import 'package:flutter/material.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {},
          child: Image.asset(
            "assets/play_icon.png",
            scale: 2.5,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Image.asset(
            "assets/pause_icon.png",
            scale: 2.5,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Image.asset(
            "assets/reset_button.png",
            scale: 2.5,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Image.asset(
            "assets/settings_button.png",
            scale: 2.5,
          ),
        ),
      ],
    );
  }
}

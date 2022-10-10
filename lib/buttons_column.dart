import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vlab1/providers.dart';
import 'package:vlab1/settings_dialog.dart';

import 'actions_view.dart';

class ButtonsColumn extends StatelessWidget {
  const ButtonsColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActionsView actionsView = context.read(actionsViewProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            actionsView.isPaused = false;
          },
          child: Image.asset(
            "assets/play_icon.png",
            scale: 2.5,
          ),
        ),
        TextButton(
          onPressed: () {
            actionsView.isPaused = true;
          },
          child: Image.asset(
            "assets/pause_icon.png",
            scale: 2.5,
          ),
        ),
        TextButton(
          onPressed: () {
            actionsView.isPaused = false;
            actionsView.initValues();
          },
          child: Image.asset(
            "assets/reset_button.png",
            scale: 2.5,
          ),
        ),
        TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SettingsDialog();
                });
          },
          child: Image.asset(
            "assets/settings_button.png",
            scale: 2.5,
          ),
        ),
      ],
    );
  }
}

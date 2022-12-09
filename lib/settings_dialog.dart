import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vlab1/actions_view.dart';
import 'package:vlab1/app_config.dart';

import 'providers.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    ActionsView actionsView = context.read(actionsViewProvider);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: 400,
        width: 500,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Settings",
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "M1",
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                          ),
                          Slider(
                            min: 1,
                            max: 10.0,
                            value: actionsView.massOne,
                            divisions: 9,
                            label: '${actionsView.massOne}',
                            onChanged: (value) {
                              setState(() {
                                actionsView.massOne = value;
                                actionsView.calRMinimum();
                              });
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "M2",
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                          ),
                          Slider(
                            min: 1,
                            max: 4000.0,
                            value: actionsView.massTwo,
                            divisions: 9,
                            label: '${actionsView.massTwo}',
                            onChanged: (value) {
                              setState(() {
                                actionsView.massTwo = value;
                                actionsView.calRMinimum();
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  if (AppConfigs.allowVelocityEdit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "V1",
                              style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                            ),
                            Slider(
                              min: -5.0,
                              max: 5.0,
                              value: actionsView.v1,
                              divisions: 10,
                              label: '${actionsView.v1}',
                              onChanged: (value) {
                                setState(() {
                                  actionsView.v1 = value;
                                  actionsView.calRMinimum();
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "V2",
                              style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                            ),
                            Slider(
                              min: -5.0,
                              max: 5.0,
                              value: actionsView.v2,
                              divisions: 10,
                              label: '${actionsView.v2}',
                              onChanged: (value) {
                                setState(() {
                                  actionsView.v2 = value;
                                  actionsView.calRMinimum();
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Will Collide? : ${actionsView.rmin < 30 ? true : false}")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

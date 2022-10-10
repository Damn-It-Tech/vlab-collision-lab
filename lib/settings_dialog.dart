import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vlab1/actions_view.dart';

import 'providers.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

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
                          SizedBox(
                            width: 200,
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter mass of first object',
                              ),
                              controller: actionsView.m1,
                              maxLines: 1,
                              maxLength: 3,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            ),
                          ),
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
                          SizedBox(
                            width: 200,
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter mass of second object',
                              ),
                              controller: actionsView.m2,
                              maxLines: 1,
                              maxLength: 3,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text(
                  //           "Z1",
                  //           style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                  //         ),
                  //         SizedBox(
                  //           width: 200,
                  //           child: TextField(
                  //             decoration: const InputDecoration(
                  //               border: OutlineInputBorder(),
                  //               hintText: 'Enter charge of first object',
                  //             ),
                  //             controller: m1,
                  //             maxLines: 1,
                  //             maxLength: 3,
                  //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       width: 50,
                  //     ),
                  //     Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Z2",
                  //           style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                  //         ),
                  //         SizedBox(
                  //           width: 200,
                  //           child: TextField(
                  //             decoration: const InputDecoration(
                  //               border: OutlineInputBorder(),
                  //               hintText: 'Enter charge of second object',
                  //             ),
                  //             controller: m1,
                  //             maxLines: 1,
                  //             maxLength: 3,
                  //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

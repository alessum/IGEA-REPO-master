import 'dart:io';

import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/screens/camera/camera_screen.dart';
import 'package:igea_app/screens/welcome/ui_components/prevengo_onboarding_button.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class PrevengoModalOuctomeImage extends StatelessWidget {
  final File imageFile;

  const PrevengoModalOuctomeImage({Key key, this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(media.width * .02),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CloseLineTopModal(),
          SizedBox(height: media.height * .02),
          Container(
            width: media.width,
            padding: EdgeInsets.only(left: media.width * .05),
            child: Text(
              'Foto dell\'esito',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: media.width * .07,
                fontFamily: 'Gotham',
              ),
            ),
          ),
          SizedBox(height: media.height * .02),
          Image.file(
            imageFile,
            height: media.height * 0.7,
          ),
          SizedBox(height: media.height * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PrevengoOnboardingButton(
                colorTheme: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                label: 'Ok, va bene',
                fontSize: media.width * .04,
                onTap: () => Navigator.pop(context),
                width: media.width * .4,
              ),
              PrevengoOnboardingButton(
                colorTheme: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                label: 'Cambia',
                fontSize: media.width * .04,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraScreen(),
                    ),
                  );
                },
                width: media.width * .4,
              ),
            ],
          )
        ],
      ),
    );
  }
}

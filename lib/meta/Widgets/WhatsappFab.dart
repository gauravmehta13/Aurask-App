import 'package:aurask/meta/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WhatsappFAB extends StatelessWidget {
  const WhatsappFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        launchWhatsApp();
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      backgroundColor: Color(0xFF25D366),
      child: FaIcon(
        FontAwesomeIcons.whatsapp,
        size: 30,
      ),
    );
  }
}

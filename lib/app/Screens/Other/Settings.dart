import 'package:aurask/app/auth/Login.dart';
import 'package:aurask/app/auth/Onboarding.dart';
import 'package:aurask/core/resources/theme/theme_notifier.dart';
import 'package:aurask/meta/Utility/Constants.dart';
import 'package:aurask/meta/Utility/Fade%20Route.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var isDarkTheme;
  late SharedPreferences prefs;
  late ThemeNotifier themeNotifier;
  @override
  Widget build(BuildContext context) {
    isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: primaryColor,
      ),
      body: Theme(
          data: ThemeData(platform: TargetPlatform.iOS),
          child: buildSettingsList()),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'Common',
          tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: 'English',
              leading: Icon(Icons.language),
              onPressed: (context) {
                displaySnackBar("Coming Soon", context);
              },
            ),
            SettingsTile(
              title: 'Change App Theme',
              leading: Icon(
                Icons.colorize,
                color: primaryColor,
              ),
              onPressed: (context) {
                colorPickerDialog();
              },
            ),
            SettingsTile.switchTile(
              title: 'Dark Mode',
              leading: Icon(
                Icons.dark_mode,
              ),
              enabled: false,
              switchValue: isDarkTheme,
              onToggle: (e) {
                e ? onThemeChanged("Dark") : onThemeChanged("System default");
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Account',
          tiles: [
            SettingsTile(
              title: 'Sign out',
              leading: Icon(Icons.exit_to_app),
              onPressed: (e) {
                auth.signOut().then((value) => Navigator.pushReplacement(
                      context,
                      FadeRoute(page: LoginScreen()),
                    ));
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Security',
          tiles: [
            SettingsTile.switchTile(
              title: 'Enable Notifications',
              enabled: false,
              leading: Icon(Icons.notifications_active),
              switchValue: true,
              onToggle: (value) {
                displaySnackBar("Coming Soon", context);
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Misc',
          tiles: [
            SettingsTile(
              title: 'About Us',
              leading: Icon(Icons.business_outlined),
              onPressed: (e) {
                Navigator.push(context, FadeRoute(page: Onboarding()));
              },
            ),
            SettingsTile(
                title: 'Contact Us', leading: Icon(Icons.contact_mail)),
            SettingsTile(
                title: 'Terms of Service', leading: Icon(Icons.description)),
            SettingsTile(
                title: 'Refund and Cancellation policy',
                leading: Icon(Icons.cancel_schedule_send)),
            SettingsTile(
                title: 'Privacy Policy',
                leading: Icon(Icons.collections_bookmark)),
          ],
        ),
        // CustomSection(
        //   child: Column(
        //     children: [
        //       box30,
        //       Text(
        //         'Version: 2.4.0 (287)',
        //         style: TextStyle(color: Color(0xFF777777)),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  void onThemeChanged(String value) async {
    var prefs = await SharedPreferences.getInstance();
    if (value == "System default") {
      themeNotifier.setThemeMode(ThemeMode.system);
    } else if (value == "Dark") {
      themeNotifier.setThemeMode(ThemeMode.dark);
    } else {
      themeNotifier.setThemeMode(ThemeMode.light);
    }
    prefs.setString("Theme", value);
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: primaryColor,
      onColorChanged: (Color color) async {
        prefs = await SharedPreferences.getInstance();
        setState(() async {
          prefs.setInt("color", color.value);
          primaryColor = color;
        });
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyText2,
      colorCodePrefixStyle: Theme.of(context).textTheme.caption,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      //  customColorSwatchesAndNames: colorsNameMap,
    )
        .showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    )
        .then((value) {
      setState(() {});
      return true;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class NotificationSettingsUI extends StatefulWidget {
  @override
  _NotificationSettingsUIState createState() => _NotificationSettingsUIState();
}

class _NotificationSettingsUIState extends State<NotificationSettingsUI> {
  
  // identifier for enable/disable notifications
  bool _newsletter = false;
  bool _promo = true;
  bool _blog = true;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.notifications.appBar')}"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(Sizes.s15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("${lang.translate('screen.notifications.newsLetterTitle')}"),
              subtitle: Text("${lang.translate('screen.notifications.newsLetterSubtitle')}"),
              trailing: FlutterSwitch(
                height: Sizes.s25,
                width: Sizes.s50,
                valueFontSize: 0.0,
                value: _newsletter,
                padding: Sizes.s3,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    _newsletter = val;
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("${lang.translate('screen.notifications.promoTitle')}"),
              subtitle: Text("${lang.translate('screen.notifications.promoSubtitle')}"),
              trailing: FlutterSwitch(
                height: Sizes.s25,
                width: Sizes.s50,
                valueFontSize: 0.0,
                value: _promo,
                padding: Sizes.s3,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    _promo = val;
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("${lang.translate('screen.notifications.blogTitle')}"),
              subtitle: Text("${lang.translate('screen.notifications.blogSubtitle')}"),
              trailing: FlutterSwitch(
                height: Sizes.s25,
                width: Sizes.s50,
                valueFontSize: 0.0,
                value: _blog,
                padding: Sizes.s3,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    _blog = val;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

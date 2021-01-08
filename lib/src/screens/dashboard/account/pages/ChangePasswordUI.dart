import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/inputs.dart';

class ChangePasswordUI extends StatefulWidget {
  @override
  _ChangePasswordUIState createState() => _ChangePasswordUIState();
}

class _ChangePasswordUIState extends State<ChangePasswordUI> {
  
  // identifier for obscure password
  bool hideOldPassword = true;
  bool hideNewPassword = true;
  bool hideConfirmNewPassword = true;

  Widget get divider {
    return SizedBox(
      height: Sizes.s25,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.changePassword.appBar')}"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView(
          padding: EdgeInsets.all(Sizes.s15),
          children: <Widget>[
            OutlineTextField(
              hintText: "${lang.translate('screen.changePassword.oldPasswordHint')}",
              labelText: "${lang.translate('screen.changePassword.oldPasswordLabel')}",
              obscureText: hideOldPassword,
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
              suffixIcon: IconButton(
                icon: hideOldPassword
                    ? Icon(FlutterIcons.eye_fea)
                    : Icon(FlutterIcons.eye_off_fea),
                onPressed: () => setState(
                    () => hideOldPassword = hideOldPassword ? false : true),
              ),
            ),
            divider,
            OutlineTextField(
              hintText: "${lang.translate('screen.changePassword.newPasswordHint')}",
              labelText: "${lang.translate('screen.changePassword.newPasswordLabel')}",
              obscureText: hideNewPassword,
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
              suffixIcon: IconButton(
                icon: hideNewPassword
                    ? Icon(FlutterIcons.eye_fea)
                    : Icon(FlutterIcons.eye_off_fea),
                onPressed: () => setState(
                    () => hideNewPassword = hideNewPassword ? false : true),
              ),
            ),
            divider,
            OutlineTextField(
              hintText: "${lang.translate('screen.changePassword.newPasswordConfirmHint')}",
              labelText: "${lang.translate('screen.changePassword.newPasswordConfirmLabel')}",
              obscureText: hideConfirmNewPassword,
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
              suffixIcon: IconButton(
                icon: hideConfirmNewPassword
                    ? Icon(FlutterIcons.eye_fea)
                    : Icon(FlutterIcons.eye_off_fea),
                onPressed: () => setState(() => hideConfirmNewPassword =
                    hideConfirmNewPassword ? false : true),
              ),
            ),
            divider,
            Container(
              height: Sizes.s50,
              child: GradientButton(
                title: "${lang.translate('screen.changePassword.saveButton')}",
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/modal.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/inputs.dart';

class ResetPasswordUI extends StatefulWidget {
  @override
  _ResetPasswordUIState createState() => _ResetPasswordUIState();
}

class _ResetPasswordUIState extends State<ResetPasswordUI> {
  bool _isReset = true;

  Widget _resetBuilder() {
    var lang = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "${lang.translate('screen.resetPassword.resetTitle')}",
          style: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Sizes.s20),
        Text(
          "${lang.translate('screen.resetPassword.resetSubtitle')}",
          style: TextStyle(
            fontSize: FontSize.s14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        Image.asset(
          "assets/images/icons/mail.png",
          width: Sizes.s150,
        ),
        SizedBox(height: Sizes.s20),
        OutlineTextField(
          hintText: "${lang.translate('screen.resetPassword.emailHint')}",
          labelText: "${lang.translate('screen.resetPassword.emailLabel')}",
        ),
        SizedBox(height: Sizes.s10),
        Container(
          margin: EdgeInsets.only(top: Sizes.s20),
          height: Sizes.s50,
          child: GradientButton(
            title: "${lang.translate('screen.resetPassword.resetButton')}",
            onTap: () async {
              showModalBottomSheet<void>(
                context: context,
                backgroundColor: Colors.transparent,
                isDismissible: false,
                builder: (BuildContext context) {
                  return CustomModal.loading(
                    context,
                    "Sending Email..",
                  );
                },
              );
              await Future.delayed(
                Duration(milliseconds: 2500),
                () => Navigator.pop(context),
              );
              setState(() {
                _isReset = false;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _successBuilder() {
    var lang = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "${lang.translate('screen.resetPassword.successTitle')}",
          style: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Sizes.s20),
        Text(
          "${lang.translate('screen.resetPassword.successSubtitle')}",
          style: TextStyle(
            fontSize: FontSize.s14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Sizes.s20),
        Image.asset(
          "assets/images/icons/check.png",
          width: Sizes.s150,
        ),
        SizedBox(height: Sizes.s20),
        Container(
          margin: EdgeInsets.only(top: Sizes.s20),
          height: Sizes.s50,
          child: GradientButton(
            title: "${lang.translate('screen.resetPassword.successButton')}",
            onTap: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.resetPassword.appBar')}"),
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(Sizes.s15),
        child: _isReset ? _resetBuilder() : _successBuilder(),
      ),
    );
  }
}

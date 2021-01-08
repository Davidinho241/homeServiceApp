import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/inputs.dart';

class PersonalInformationUI extends StatefulWidget {
  @override
  _PersonalInformationUIState createState() => _PersonalInformationUIState();
}

class _PersonalInformationUIState extends State<PersonalInformationUI> {
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
        title: Text("${lang.translate('screen.personalInfo.appBar')}"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView(
          padding: EdgeInsets.all(Sizes.s15),
          children: <Widget>[
            Text(
              "${lang.translate('screen.personalInfo.nameTag')}",
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Sizes.s10),
            OutlineTextField(
              hintText:
                  "${lang.translate('screen.personalInfo.firstNameHint')}",
              labelText:
                  "${lang.translate('screen.personalInfo.firstNameLabel')}",
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
            ),
            divider,
            OutlineTextField(
              hintText: "${lang.translate('screen.personalInfo.lastNameHint')}",
              labelText:
                  "${lang.translate('screen.personalInfo.lastNameHint')}",
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
            ),
            SizedBox(height: Sizes.s35),
            Text(
              "${lang.translate('screen.personalInfo.addressTag')}",
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Sizes.s10),
            OutlineTextField(
              hintText: "${lang.translate('screen.personalInfo.provinceHint')}",
              labelText:
                  "${lang.translate('screen.personalInfo.provinceLabel')}",
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
            ),
            divider,
            OutlineTextField(
              hintText: "${lang.translate('screen.personalInfo.cityHint')}",
              labelText: "${lang.translate('screen.personalInfo.cityLabel')}",
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
            ),
            divider,
            OutlineTextField(
              hintText:
                  "${lang.translate('screen.personalInfo.streetAddressHint')}",
              labelText:
                  "${lang.translate('screen.personalInfo.streetAddressLabel')}",
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
            ),
            divider,
            OutlineTextField(
              hintText: "${lang.translate('screen.personalInfo.postalHint')}",
              labelText: "${lang.translate('screen.personalInfo.postalLabel')}",
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
            ),
            SizedBox(height: Sizes.s35),
            Text(
              "${lang.translate('screen.personalInfo.detailsTag')}",
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Sizes.s10),
            OutlineTextField(
              hintText: "${lang.translate('screen.personalInfo.genderHint')}",
              labelText: "${lang.translate('screen.personalInfo.genderLabel')}",
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
            ),
            divider,
            OutlineTextField(
              hintText:
                  "${lang.translate('screen.personalInfo.birthDateHint')}",
              labelText:
                  "${lang.translate('screen.personalInfo.birthDateLabel')}",
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
            ),
            divider,
            OutlineTextField(
              hintText: "${lang.translate('screen.personalInfo.emailHint')}",
              labelText: "${lang.translate('screen.personalInfo.emailLabel')}",
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
            ),
            divider,
            OutlineTextField(
              hintText: "${lang.translate('screen.personalInfo.phoneHint')}",
              labelText: "${lang.translate('screen.personalInfo.phoneLabel')}",
              hintStyle: TextStyle(fontSize: FontSize.s14),
              labelStyle: TextStyle(fontSize: FontSize.s14),
            ),
            divider,
            Container(
              height: Sizes.s50,
              child: GradientButton(
                title: "${lang.translate('screen.personalInfo.saveButton')}",
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

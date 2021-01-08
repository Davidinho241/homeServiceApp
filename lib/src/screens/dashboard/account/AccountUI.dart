import 'package:country_pickers/countries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotel_ui_kit/src/blocs/language.bloc.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/models/CountryOptionModel.dart';
import 'package:hotel_ui_kit/src/screens/dashboard/account/pages/AccountSettingsUI.dart';
import 'package:hotel_ui_kit/src/screens/dashboard/account/pages/PersonalInformationUI.dart';
import 'package:hotel_ui_kit/src/screens/registration/RegisterUI.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/common_widgets.dart';
import 'pages/ChangePasswordUI.dart';
import 'pages/NotificationSettingsUI.dart';
import 'pages/PaymentInformationUI.dart';

class AccountUI extends StatefulWidget {
  @override
  _AccountUIState createState() => _AccountUIState();
}

class _AccountUIState extends State<AccountUI> {
  bool isEdit = false;
  bool enableNotification = false;

  List<CountryOption> countries = [
    CountryOption(
      country: countryList.firstWhere((e) => e.isoCode == "FR"),
      selected: false,
      currency: "XAF",
      lang: "French",
      code: Language.FR,
    ),
    CountryOption(
      country: countryList.firstWhere((e) => e.isoCode == "US"),
      selected: false,
      currency: "XAF",
      lang: "English",
      code: Language.EN,
    ),
  ];

  Widget get divider {
    return SizedBox(
      height: Sizes.s25,
    );
  }

  Widget _profileCard() {
    return Container(
      margin: EdgeInsets.only(bottom: Sizes.s30, top: Sizes.s20),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: Sizes.s50,
            backgroundColor: Theme.of(context).cardColor,
            backgroundImage: NetworkImage(
              "https://i.ibb.co/X3DW7mT/portrait-2194457-640.jpg",
            ),
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            height: Sizes.s10,
          ),
          Text(
            "John Doe",
            style: TextStyle(
              fontSize: FontSize.s16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "john.doe@mail.com",
            style: TextStyle(
              fontSize: FontSize.s14,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _logoutButton() {
    var lang = AppLocalizations.of(context);
    return InkWell(
      onTap: () {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("${lang.translate('screen.account.logoutTitle')}"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      "${lang.translate('screen.account.logoutSubtitle')}",
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child:
                      Text("${lang.translate('screen.account.approveButton')}"),
                  onPressed: () => openRemovePage(context, RegisterUI()),
                ),
                FlatButton(
                  child:
                      Text("${lang.translate('screen.account.cancelButton')}"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Sizes.s10),
        height: Sizes.s50,
        child: Row(
          children: <Widget>[
            Icon(
              Feather.log_out,
              size: FontSize.s18,
              color: Colors.red[400],
            ),
            SizedBox(
              width: Sizes.s10,
            ),
            Text(
              "${lang.translate('screen.account.logOut')}",
              style: TextStyle(
                fontSize: FontSize.s16,
                color: Colors.red[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.account.appBar')}"),
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(Sizes.s15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _profileCard(),
              AccountTile(
                icons: Feather.user,
                title:
                    "${lang.translate('screen.account.personalInformation')}",
                onTap: () => openPage(context, PersonalInformationUI()),
              ),
              AccountTile(
                icons: Feather.lock,
                title: "${lang.translate('screen.account.changePassword')}",
                onTap: () => openPage(context, ChangePasswordUI()),
              ),
              AccountTile(
                icons: Feather.credit_card,
                title: "${lang.translate('screen.account.payments')}",
                onTap: () => openPage(context, PaymentInformationUI()),
              ),
              AccountTile(
                icons: Feather.bell,
                title: "${lang.translate('screen.account.notifications')}",
                onTap: () => openPage(context, NotificationSettingsUI()),
              ),
              AccountTile(
                icons: Feather.settings,
                title: "${lang.translate('screen.account.settings')}",
                onTap: () => openPage(context, AccountSettingsUI()),
              ),
              _logoutButton()
            ],
          ),
        ),
      ),
    );
  }
}

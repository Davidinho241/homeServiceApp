import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/screens/customer_service/CustomerServiceUI.dart';
import 'package:hotel_ui_kit/src/screens/dashboard/account/AccountUI.dart';
import 'package:hotel_ui_kit/src/screens/dashboard/booking/BookingUI.dart';
import 'package:hotel_ui_kit/src/screens/wallet/WalletUI.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'home/HomeUI.dart';
import 'notification/NotificationUI.dart';

class DashboardUI extends StatefulWidget {
  @override
  _DashboardUIState createState() => _DashboardUIState();
}

class _DashboardUIState extends State<DashboardUI> {
  // default active index
  int currentIndex = 0;

  // app bar title for every tab
  String appBarTitle(context) {
    var lang = AppLocalizations.of(context);
    switch (currentIndex) {
      // first tab
      case 0:
        return "${lang.translate('screen.dashboard.firstAppBar')}";
        break;
      // second tab
      case 1:
        return "${lang.translate('screen.dashboard.secondAppBar')}";
        break;
      // third tab
      case 2:
        return "${lang.translate('screen.dashboard.thirdAppBar')}";
        break;
      // fourth tab
      case 3:
        return "${lang.translate('screen.dashboard.fourhAppBar')}";
        break;
      // if unknown
      default:
        return "";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      // if active tab is not account ui
      appBar: currentIndex != 3
          ? AppBar(
              elevation: 0,
              title: Row(
                children: <Widget>[
                  currentIndex == 0
                      ? Icon(
                          Feather.compass,
                          color: primaryColor,
                          size: FontSize.s15,
                        )
                      : Container(),
                  currentIndex == 0
                      ? Container(
                          width: Sizes.s10,
                        )
                      : Container(),
                  Text(
                    appBarTitle(context),
                    style: TextStyle(
                      fontSize: FontSize.s16,
                      color: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .color
                          .withOpacity(.7),
                    ),
                  )
                ],
              ),
              actions: currentIndex == 0
                  ? <Widget>[
                      IconButton(
                        icon: Icon(
                          FlutterIcons.wallet_mco,
                          color: Colors.grey,
                        ),
                        onPressed: () => openPage(context, WalletUI()),
                      ),
                      IconButton(
                        icon: Icon(
                          FlutterIcons.chat_processing_mco,
                          color: Colors.grey,
                        ),
                        onPressed: () => openPage(context, CustomerServiceUI()),
                      ),
                    ]
                  : [],
            )
          : null,
      body: IndexedStack(
        index: currentIndex,
        children: <Widget>[
          HomeUI(),
          NotificationUI(),
          BookingUI(),
          AccountUI(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Feather.home),
            title: Text("${lang.translate('screen.dashboard.firstTab')}"),
            activeColor: primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Feather.bell),
            title: Text("${lang.translate('screen.dashboard.secondTab')}"),
            activeColor: primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Feather.list),
            title: Text("${lang.translate('screen.dashboard.thirdTab')}"),
            activeColor: primaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Feather.user),
            title: Text("${lang.translate('screen.dashboard.fourthTab')}"),
            activeColor: primaryColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

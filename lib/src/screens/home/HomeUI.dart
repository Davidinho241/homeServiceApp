import 'package:flutter/material.dart';
import 'package:home_service/src/helpers/currency.dart';
import 'package:home_service/src/helpers/localization.dart';
import 'package:home_service/src/utils/themes.dart';
import 'package:home_service/src/utils/sizes.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  // initializing data
  initializeData() async {

  }

  Widget nearbyCard() {
    var lang = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: Sizes.s20, right: Sizes.s10),
      child: Column(
        children: <Widget>[
          Container(
            height: Sizes.s50,
            width: Sizes.s50,
            decoration: BoxDecoration(
              gradient: customGradient(),
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.s10),
              ),
            ),
            child: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Sizes.s5),
          Text(
            "${lang.translate('screen.home.nearMe')}",
            style: TextStyle(
              fontSize: FontSize.s12,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    // init localization
    var lang = AppLocalizations.of(context);
    // init currency
    String currency = userCurrency(context);
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}

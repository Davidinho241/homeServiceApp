import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/models/WalletHistoryModel.dart';
import 'package:hotel_ui_kit/src/screens/topup/TopupUI.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/cards.dart';

class WalletUI extends StatefulWidget {
  @override
  _WalletUIState createState() => _WalletUIState();
}

class _WalletUIState extends State<WalletUI> {
  List<WalletHistory> _walletHistory = [
    WalletHistory(
      title: "Cash Out",
      subtitle: "Payment for Hotel Lorem",
      cash: 115000,
      date: "18/02/20",
      type: "cash_out",
    ),
    WalletHistory(
      title: "Cancelation",
      subtitle: "Cancelation booking payment for Hotel Lorem",
      cash: 40000,
      date: "12/02/20",
      type: "cash_cancel",
    ),
    WalletHistory(
      title: "Cash In",
      subtitle: "Top Up from PayPal",
      cash: 200000,
      date: "15/01/20",
      type: "cash_in",
    ),
    WalletHistory(
      title: "Cash In",
      subtitle: "Bonus points from invitation",
      cash: 220000,
      date: "10/01/20",
      type: "cash_in",
    ),
  ];

  Color colorParse(String type) {
    switch (type) {
      case "cash_in":
        return Colors.green;
        break;
      case "cash_out":
        return Colors.red;
        break;
      case "cash_cancel":
        return Colors.orange;
        break;
      default:
        return Colors.grey;
        break;
    }
  }

  String cashType(String type) {
    switch (type) {
      case "cash_in":
        return "+";
        break;
      case "cash_out":
        return "-";
        break;
      case "cash_cancel":
        return "+";
        break;
      default:
        return "";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.wallet.appBar')}"),
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(Sizes.s10),
        child: Column(
          children: <Widget>[
            Icon(
              FlutterIcons.wallet_ent,
              size: Sizes.s100,
              color: Colors.grey[600],
            ),
            SizedBox(height: Sizes.s10),
            Text(
              "200,000 ${lang.translate('screen.wallet.points')}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: FontSize.s20,
              ),
            ),
            // SizedBox(height: Sizes.s5),
            Text(
              "${lang.translate('screen.wallet.accountBalance')}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: FontSize.s14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: Sizes.s15),
            Container(
              width: Sizes.s120,
              height: Sizes.s40,
              child: GradientButton(
                title: "${lang.translate('screen.wallet.topUp')}",
                onTap: () => openPage(context, TopupUI()),
              ),
            ),
            SizedBox(height: Sizes.s20),
            Divider(),
            SizedBox(height: Sizes.s10),
            Expanded(
              flex: 1,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _walletHistory.length,
                itemBuilder: (context, index) {
                  WalletHistory history = _walletHistory[index];
                  return WalletHistoryCard(
                    title: history.title,
                    subtitle: history.subtitle,
                    cash: "${cashType(history.type)}${history.cash}",
                    date: history.date,
                    cashColor: colorParse(history.type),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

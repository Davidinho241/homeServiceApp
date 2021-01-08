import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/currency.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/modal.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/screens/payment_success/PaymentSuccessUI.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class TopupUI extends StatefulWidget {
  @override
  _TopupUIState createState() => _TopupUIState();
}

class _TopupUIState extends State<TopupUI> {
  Widget paymentMethod(String title, String image) {
    return ListTile(
      onTap: () async {
        showModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          isDismissible: false,
          builder: (BuildContext context) {
            return CustomModal.loading(
              context,
              "Processing Payment..",
            );
          },
        );
        Future.delayed(
          Duration(milliseconds: 2500),
          () {
            Navigator.pop(context);
            openPage(
              context,
              PaymentSuccessUI(showReview: false),
            );
          },
        );
      },
      leading: Container(
        width: Sizes.s40,
        height: Sizes.s40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(
              "$image",
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      contentPadding: EdgeInsets.zero,
      title: Text("$title"),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    // init currency
    String currency = userCurrency(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.topup.appBar')}"),
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(Sizes.s10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              style: TextStyle(
                fontSize: FontSize.s18,
              ),
              decoration: InputDecoration(
                hintText: "${currency}0",
                labelText: "${lang.translate('screen.topup.nominal')}",
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
            Divider(),
            SizedBox(height: Sizes.s20),
            Text(
              "${lang.translate('screen.topup.paymentMethod')}",
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Sizes.s20),
            Expanded(
              flex: 1,
              child: ListView(
                children: <Widget>[
                  paymentMethod(
                    "Paypal",
                    "https://cdn.iconscout.com/icon/free/png-256/paypal-32-498436.png",
                  ),
                  paymentMethod(
                    "Stripe",
                    "https://cdn.iconscout.com/icon/free/png-512/stripe-2-498440.png",
                  ),
                  paymentMethod(
                    "2Checkout",
                    "https://e7.pngegg.com/pngimages/775/501/png-clipart-2checkout-payment-gateway-e-commerce-logo-others-miscellaneous-text.png",
                  ),
                  paymentMethod(
                    "Braintree",
                    "https://assets.codepen.io/346994/internal/avatars/users/default.png",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

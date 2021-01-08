import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/utils/themes.dart';
import 'package:hotel_ui_kit/src/screens/reviews/WriteReviewUI.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';

class PaymentSuccessUI extends StatefulWidget {
  final bool showReview;
  PaymentSuccessUI({this.showReview = true});

  @override
  _PaymentSuccessUIState createState() => _PaymentSuccessUIState();
}

class _PaymentSuccessUIState extends State<PaymentSuccessUI> {
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        margin: EdgeInsets.all(Sizes.s25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
              width: Sizes.s120,
              height: Sizes.s120,
              decoration: BoxDecoration(
                gradient: customGradient(),
                shape: BoxShape.circle,
                // color: primaryColor.withOpacity(.8),
              ),
              child: Icon(
                Feather.check,
                color: Colors.white,
                size: Sizes.s50,
              ),
            ),
            SizedBox(
              height: Sizes.s15,
            ),
            Text(
              "${lang.translate('screen.paymentSuccess.body')}",
              style: TextStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            widget.showReview
                ? Container(
                    height: Sizes.s50,
                    margin: EdgeInsets.only(bottom: Sizes.s15, top: Sizes.s25),
                    child: GradientButton(
                      title:
                          "${lang.translate('screen.paymentSuccess.button')}",
                      onTap: () => openPage(context, WriteReviewUI()),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

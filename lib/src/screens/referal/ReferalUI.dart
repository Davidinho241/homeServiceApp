import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class ReferalUI extends StatefulWidget {
  @override
  _ReferalUIState createState() => _ReferalUIState();
}

class _ReferalUIState extends State<ReferalUI> {
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.referal.appBar')}"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(Sizes.s15),
        child: ListView(
          children: <Widget>[
            Image.asset(
              "assets/images/misc/referal.png",
              height: Sizes.s180,
            ),
            SizedBox(height: Sizes.s15),
            Center(
              child: Text(
                "${lang.translate('screen.referal.title')}",
                style: TextStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: Sizes.s5),
            Center(
              child: Text(
                "${lang.translate('screen.referal.subtitle')}",
                style: TextStyle(
                  fontSize: FontSize.s14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Sizes.s15),
            DottedBorder(
              color: Colors.grey,
              strokeWidth: 1,
              child: Container(
                margin: EdgeInsets.only(left: Sizes.s10, right: Sizes.s10),
                height: Sizes.s50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        "https://app.whateverappname.com/axcc2aq7d8",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          fontSize: FontSize.s12,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.content_copy,
                          size: FontSize.s15,
                        ),
                        Text(
                          "${lang.translate('screen.referal.copyButton')}",
                          style: TextStyle(
                            fontSize: FontSize.s10,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: Sizes.s20),
            Center(
              child: Text(
                "${lang.translate('screen.referal.bodyTitle')}",
                style: TextStyle(
                  fontSize: FontSize.s20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: Sizes.s20),
            Card(
              margin: EdgeInsets.only(bottom: Sizes.s20),
              child: Container(
                margin: EdgeInsets.only(top: Sizes.s10, bottom: Sizes.s10),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/icons/money.png",
                    height: Sizes.s40,
                  ),
                  title: Text("${lang.translate('screen.referal.b1title')}"),
                  subtitle:
                      Text("${lang.translate('screen.referal.b1subtitle')}"),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: Sizes.s20),
              child: Container(
                margin: EdgeInsets.only(top: Sizes.s10, bottom: Sizes.s10),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/icons/forum.png",
                    height: Sizes.s40,
                  ),
                  title: Text("${lang.translate('screen.referal.b2title')}"),
                  subtitle:
                      Text("${lang.translate('screen.referal.b2subtitle')}"),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: Sizes.s20),
              child: Container(
                margin: EdgeInsets.only(top: Sizes.s10, bottom: Sizes.s10),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/icons/sale.png",
                    height: Sizes.s40,
                  ),
                  title: Text("${lang.translate('screen.referal.b3title')}"),
                  subtitle:
                      Text("${lang.translate('screen.referal.b3subtitle')}"),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: Sizes.s20),
              child: Container(
                margin: EdgeInsets.only(top: Sizes.s10, bottom: Sizes.s10),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/icons/cupboard.png",
                    height: Sizes.s40,
                  ),
                  title: Text("${lang.translate('screen.referal.b4title')}"),
                  subtitle:
                      Text("${lang.translate('screen.referal.b4subtitle')}"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

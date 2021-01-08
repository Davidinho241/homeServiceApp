import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/models/PromoModel.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class PromoDetailUI extends StatefulWidget {
  final PromoModel promo;
  PromoDetailUI({@required this.promo});

  @override
  _PromoDetailUIState createState() => _PromoDetailUIState();
}

class _PromoDetailUIState extends State<PromoDetailUI> {
  Widget _contentBuilder() {
    var lang = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.all(Sizes.s15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: Sizes.s10,
          ),
          Text(
            "${lang.translate('screen.promoDetail.postedAt')} : ${widget.promo.createdAt}",
            style: TextStyle(
              fontSize: FontSize.s12,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: Sizes.s10,
          ),
          Text(
            "${widget.promo.title}",
            style: TextStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: Sizes.s10,
          ),
          Text(
            "${widget.promo.content}",
            style: TextStyle(fontSize: FontSize.s15),
          ),
          SizedBox(
            height: Sizes.s10,
          ),
          Text(
            "${lang.translate('screen.promoDetail.expiredAt')} : ${widget.promo.expiredAt}",
            style: TextStyle(
              fontSize: FontSize.s12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.promoDetail.appBar')}"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: "assets/images/misc/placeholder.png",
                image: "${widget.promo.thumbnail}",
                fit: BoxFit.cover,
                height: Sizes.s200,
                width: double.maxFinite,
              ),
              _contentBuilder()
            ],
          ),
        ),
      ),
    );
  }
}

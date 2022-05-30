import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:home_service/src/helpers/currency.dart';
import 'package:home_service/src/helpers/localization.dart';
import 'package:home_service/src/helpers/navigation.dart';
import 'package:home_service/src/utils/themes.dart';
import 'package:home_service/src/models/BlogModel.dart';
import 'package:home_service/src/models/BookingHistory.dart';
import 'package:home_service/src/models/HotelModel.dart';
import 'package:home_service/src/utils/colors.dart';
import 'package:home_service/src/utils/sizes.dart';
import 'package:home_service/src/widgets/text_currency.dart';
import 'package:shimmer/shimmer.dart';
import 'buttons.dart';
import 'chips.dart';
import 'common_widgets.dart';

// Used at HomeUI
class NearbyCards extends StatelessWidget {
  final Hotel hotel;
  final Function onTap;
  NearbyCards({this.hotel, this.onTap});
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    // init currency
    String currency = userCurrency(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: Sizes.s20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s15),
          ),
          boxShadow: [
            customShadow(),
          ],
        ),
        child: Container(
          height: Sizes.s100,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Sizes.s80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Sizes.s10),
                      bottomLeft: Radius.circular(Sizes.s10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage("${hotel.thumbnail}"),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: Sizes.s10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: Sizes.s10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${hotel.name}",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: Sizes.s5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Feather.map_pin,
                                      size: FontSize.s10,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: Sizes.s5,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "2 ${lang.translate('widget.card.distanceLabel')}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: FontSize.s10,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                Sizes.s10,
                                0,
                                Sizes.s10,
                                0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  RatingsValue(
                                    rating: "${hotel.rating}",
                                  ),
                                  Text(
                                    "${hotel.discountText}",
                                    style: TextStyle(
                                      fontSize: FontSize.s10,
                                      color: Colors.red,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: '',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '$currency',
                                          style: TextStyle(
                                            fontSize: Sizes.s8,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "${hotel.discountPrice}",
                                          style: TextStyle(
                                            fontSize: FontSize.s12,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            0,
                            Sizes.s10,
                            Sizes.s10,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: '',
                              style: Theme.of(context).textTheme.subtitle1,
                              children: <TextSpan>[
                                TextSpan(
                                  text: '$currency',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.s10,
                                    color: primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: "${hotel.price}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.s15,
                                    color: primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: " /" +
                                      "${lang.translate('widget.card.nightLabel')}",
                                  style: TextStyle(
                                    fontSize: FontSize.s10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Used at HomeUI
class NearbyCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizes.s20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.s15),
        ),
        boxShadow: [
          customShadow(),
        ],
      ),
      child: Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          child: Container(
            height: Sizes.s90,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Sizes.s80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Sizes.s10),
                      bottomLeft: Radius.circular(Sizes.s10),
                    ),
                  ),
                ),
                SizedBox(
                  width: Sizes.s10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: Sizes.s10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: Sizes.s10,
                          width: Sizes.s120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.s15),
                            ),
                          ),
                        ),
                        SizedBox(height: Sizes.s10),
                        Container(
                          height: Sizes.s10,
                          width: Sizes.s165,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.s15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(Sizes.s10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: Sizes.s15,
                              width: Sizes.s15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.s15),
                                ),
                              ),
                            ),
                            Container(width: 5),
                            Container(
                              height: Sizes.s15,
                              width: Sizes.s25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.s15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: Sizes.s10,
                          width: Sizes.s40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.s15),
                            ),
                          ),
                        ),
                        Container(
                          height: Sizes.s10,
                          width: Sizes.s30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.s15),
                            ),
                          ),
                        ),
                        Container(
                          height: Sizes.s10,
                          width: Sizes.s60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.s15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Used at HomeUI
class PopularCards extends StatelessWidget {
  final Hotel hotel; // hotel data
  final Function onTap; // action when user tap on card
  PopularCards({this.hotel, this.onTap});

  @override
  Widget build(BuildContext context) {
    // initialize language
    var lang = AppLocalizations.of(context);
    // initialize current active currency
    String currency = userCurrency(context);
    return InkWell(
      onTap: onTap, // ontap action
      child: Container(
        height: Sizes.s260, // card height
        width: Sizes.s200, // card width
        margin:
            EdgeInsets.fromLTRB(Sizes.s20, 0, 0, Sizes.s15), // set card margin
        decoration: BoxDecoration(
          // card color, white on light mode, and dark on dark mode
          color: Theme.of(context).cardColor,
          // makes the card round
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s15),
          ),
          // set shadow to the card
          boxShadow: [
            customShadow(),
          ],
        ),
        // card content
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // hotel image / thumbnail
            Container(
              height: Sizes.s150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Sizes.s15),
                  topRight: Radius.circular(Sizes.s15),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    "${hotel.thumbnail}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              // setting padding on card text
              padding: EdgeInsets.fromLTRB(Sizes.s10, Sizes.s10, Sizes.s10, 0),
              child: Row(
                // row alignment
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // hotel name
                        Text(
                          "${hotel.name}",
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        // hotel location
                        Text(
                          "${hotel.location}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(Sizes.s10, Sizes.s10, Sizes.s10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.subtitle1,
                            text: '',
                            children: <TextSpan>[
                              TextSpan(
                                text: '$currency',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontSize.s10,
                                ),
                              ),
                              TextSpan(
                                text: '${hotel.price}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.s15),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "per " +
                              "${lang.translate('widget.card.nightLabel')}",
                          style: TextStyle(
                            fontSize: FontSize.s10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      RatingsValue(rating: "${hotel.rating}"),
                      Text(
                        "${hotel.reviews.length} ${lang.translate('widget.card.reviewLabel')}",
                        style: TextStyle(
                          fontSize: FontSize.s10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Used at HomeUI
class PopularCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s260,
      width: Sizes.s200,
      margin: EdgeInsets.fromLTRB(Sizes.s20, 0, 0, Sizes.s15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.s15),
        ),
        boxShadow: [
          customShadow(),
        ],
      ),
      child: Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: Sizes.s150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Sizes.s15),
                    topRight: Radius.circular(Sizes.s15),
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(Sizes.s10, Sizes.s10, Sizes.s10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.s15),
                        ),
                      ),
                      width: Sizes.s150,
                      height: Sizes.s15,
                    ),
                    Container(
                      height: Sizes.s10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.s15),
                        ),
                      ),
                      width: Sizes.s100,
                      height: Sizes.s10,
                    ),
                  ],
                ),
              ),
              Container(
                height: Sizes.s5,
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(Sizes.s10, Sizes.s10, Sizes.s10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.s15),
                              ),
                            ),
                            width: Sizes.s50,
                            height: Sizes.s15,
                          ),
                          Container(
                            height: Sizes.s5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.s15),
                              ),
                            ),
                            width: Sizes.s60,
                            height: Sizes.s8,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.s15),
                            ),
                          ),
                          width: Sizes.s40,
                          height: Sizes.s12,
                        ),
                        Container(
                          height: Sizes.s10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.s15),
                            ),
                          ),
                          width: Sizes.s50,
                          height: Sizes.s8,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Used at HomeUI
class BestOfferCards extends StatelessWidget {
  final Hotel hotel;
  final Function onTap;
  BestOfferCards({this.hotel, this.onTap});
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    // init currency
    String currency = userCurrency(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(Sizes.s20, 0, Sizes.s20, Sizes.s20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s15),
          ),
          boxShadow: [
            customShadow(),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Sizes.s100,
              height: Sizes.s120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Sizes.s15),
                  bottomLeft: Radius.circular(Sizes.s15),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    "${hotel.thumbnail}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: Sizes.s10),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(right: Sizes.s10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${hotel.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${hotel.location}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: FontSize.s12,
                      ),
                    ),
                    Container(height: Sizes.s5),
                    RichText(
                      text: TextSpan(
                        text: '',
                        style: Theme.of(context).textTheme.subtitle1,
                        children: <TextSpan>[
                          TextSpan(
                            text: '$currency',
                            style: TextStyle(
                              fontSize: Sizes.s8,
                              color: Colors.redAccent,
                              decoration: TextDecoration.lineThrough,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                          TextSpan(
                            text: '${hotel.discountPrice}',
                            style: TextStyle(
                              fontSize: FontSize.s12,
                              color: Colors.redAccent,
                              decoration: TextDecoration.lineThrough,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                          TextSpan(
                            text: ' /' +
                                "${lang.translate('widget.card.nightLabel')}",
                            style: TextStyle(
                              fontSize: FontSize.s10,
                              color: Colors.redAccent,
                              decoration: TextDecoration.lineThrough,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '',
                        style: Theme.of(context).textTheme.subtitle1,
                        children: <TextSpan>[
                          TextSpan(
                            text: '$currency',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s10,
                            ),
                          ),
                          TextSpan(
                            text: '${hotel.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s15,
                            ),
                          ),
                          TextSpan(
                            text: ' /' +
                                "${lang.translate('widget.card.nightLabel')}",
                            style: TextStyle(
                              fontSize: FontSize.s10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Sizes.s10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          FlutterIcons.swimmer_faw5s,
                          size: FontSize.s15,
                          color: Colors.grey,
                        ),
                        Icon(
                          FlutterIcons.smoking_ban_faw5s,
                          size: FontSize.s15,
                          color: Colors.grey,
                        ),
                        Icon(
                          FlutterIcons.parking_faw5s,
                          size: FontSize.s15,
                          color: Colors.grey,
                        ),
                        Icon(
                          FlutterIcons.food_variant_mco,
                          size: FontSize.s15,
                          color: Colors.grey,
                        ),
                        Icon(
                          FlutterIcons.wifi_faw5s,
                          size: FontSize.s15,
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                gradient: customGradient(),
              ),
              width: Sizes.s40,
              height: Sizes.s120,
              child: Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    "${lang.translate('widget.card.bookingButton')}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Used at HomeUI
class BestOfferCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(Sizes.s20, 0, Sizes.s20, Sizes.s20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.s15),
        ),
        boxShadow: [
          customShadow(),
        ],
      ),
      child: Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Sizes.s100,
                height: Sizes.s120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Sizes.s15),
                    bottomLeft: Radius.circular(Sizes.s15),
                  ),
                ),
              ),
              SizedBox(width: Sizes.s10),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(right: Sizes.s10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.s15),
                          ),
                        ),
                        width: Sizes.s150,
                        height: Sizes.s15,
                      ),
                      Container(height: Sizes.s5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.s15),
                          ),
                        ),
                        width: Sizes.s100,
                        height: Sizes.s10,
                      ),
                      Container(height: Sizes.s15),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.s15),
                          ),
                        ),
                        width: Sizes.s60,
                        height: Sizes.s12,
                      ),
                      SizedBox(height: Sizes.s5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.s15),
                          ),
                        ),
                        width: Sizes.s70,
                        height: Sizes.s12,
                      ),
                      SizedBox(
                        height: Sizes.s10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.s5),
                              ),
                            ),
                            width: Sizes.s20,
                            height: Sizes.s20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.s5),
                              ),
                            ),
                            width: Sizes.s20,
                            height: Sizes.s20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.s5),
                              ),
                            ),
                            width: Sizes.s20,
                            height: Sizes.s20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.s5),
                              ),
                            ),
                            width: Sizes.s20,
                            height: Sizes.s20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.s5),
                              ),
                            ),
                            width: Sizes.s20,
                            height: Sizes.s20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                width: Sizes.s40,
                height: Sizes.s120,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Used at HomeUI
class PlaceCards extends StatelessWidget {
  final String image;
  final String placeName;
  PlaceCards({@required this.image, @required this.placeName});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.s70,
      height: Sizes.s70,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(Sizes.s10)),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/misc/placeholder.png",
              image: image,
              width: Sizes.s50,
              height: Sizes.s50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: Sizes.s5),
          Flexible(
            child: Text(
              "$placeName",
              style: TextStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}

// Used at HomeUI
class PlaceCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.s70,
      height: Sizes.s70,
      child: Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Sizes.s10)),
                child: Container(
                  color: Colors.white,
                  width: Sizes.s50,
                  height: Sizes.s50,
                )),
            SizedBox(height: Sizes.s5),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(Sizes.s10)),
              child: Container(
                color: Colors.white,
                width: Sizes.s60,
                height: Sizes.s10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Used at HomeUI
class BlogCards extends StatelessWidget {
  final Blog blog;
  final Function onTap;
  BlogCards({
    this.blog,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: _width - Sizes.s50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(Sizes.s15)),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/misc/placeholder.png",
                image: blog.thumbnail,
                height: Sizes.s120,
                width: _width - Sizes.s50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: Sizes.s10,
            ),
            Flexible(
              child: Text(
                "${blog.title}",
                style: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            ),
            SizedBox(
              height: Sizes.s5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Feather.clock,
                  size: FontSize.s10,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: Sizes.s5,
                ),
                Text(
                  "${blog.date}",
                  style: TextStyle(
                    fontSize: FontSize.s10,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Used at HomeUI
class BlogCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width - Sizes.s50,
      child: Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: Sizes.s120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(Sizes.s15)),
                ),
              ),
              SizedBox(
                height: Sizes.s10,
              ),
              Container(
                height: Sizes.s15,
                width: _width - Sizes.s100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.s15),
                  ),
                ),
              ),
              SizedBox(
                height: Sizes.s5,
              ),
              Container(
                height: Sizes.s10,
                width: Sizes.s100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.s15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Used at HotelListUI
class HotelListCard extends StatelessWidget {
  final Hotel hotel;
  final Function onTap;
  HotelListCard({this.hotel, this.onTap});
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    // init currency
    String currency = userCurrency(context);
    var _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Sizes.s230,
        width: double.maxFinite,
        margin: EdgeInsets.only(bottom: Sizes.s15, left: Sizes.s15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: Sizes.s120,
              child: ListView.builder(
                itemCount: hotel.pictures.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: Sizes.s15),
                    width: _width - Sizes.s150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.s15),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.s15),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/misc/placeholder.png",
                        image: hotel.pictures[index].url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: Sizes.s10),
            Container(
              margin: EdgeInsets.only(right: Sizes.s15),
              child: Text(
                "${hotel.name}",
                maxLines: 2,
                style: TextStyle(
                  fontSize: FontSize.s15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: Sizes.s5),
            Container(
              margin: EdgeInsets.only(right: Sizes.s15),
              child: Text(
                "${hotel.fullLocation}",
                maxLines: 2,
                style: TextStyle(
                  fontSize: FontSize.s12,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: Sizes.s15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: Theme.of(context).textTheme.subtitle1,
                      children: <TextSpan>[
                        TextSpan(
                          text: '$currency',
                          style: TextStyle(
                            fontSize: Sizes.s12,
                          ),
                        ),
                        TextSpan(
                          text: "${hotel.price}",
                          style: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Sizes.s5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: Theme.of(context).textTheme.subtitle1,
                      children: <TextSpan>[
                        TextSpan(
                          text: '$currency',
                          style: TextStyle(
                            fontSize: Sizes.s10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                        TextSpan(
                          text: "${hotel.discountPrice}",
                          style: TextStyle(
                            fontSize: FontSize.s14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Sizes.s10,
                  ),
                  Text(
                    "${hotel.discountText}",
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      RatingsValue(rating: "${hotel.rating}"),
                      Text(
                        "${hotel.reviews.length} ${lang.translate('widget.card.reviewLabel')}",
                        style: TextStyle(
                          fontSize: FontSize.s10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Used at HotelListUI
class HotelListLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Container(
      height: Sizes.s200,
      width: double.maxFinite,
      margin:
          EdgeInsets.only(bottom: Sizes.s10, left: Sizes.s15, right: Sizes.s15),
      child: Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.s15),
                ),
              ),
              height: Sizes.s100,
              width: double.maxFinite,
            ),
            SizedBox(height: Sizes.s10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.s15),
                ),
              ),
              width: _width - Sizes.s100,
              height: Sizes.s15,
            ),
            SizedBox(height: Sizes.s10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.s15),
                ),
              ),
              width: _width - Sizes.s150,
              height: Sizes.s15,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.s15),
                      ),
                    ),
                    width: Sizes.s50,
                    height: Sizes.s15,
                  ),
                  SizedBox(
                    width: Sizes.s10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.s15),
                      ),
                    ),
                    width: Sizes.s50,
                    height: Sizes.s15,
                  ),
                  SizedBox(
                    width: Sizes.s10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.s15),
                      ),
                    ),
                    width: Sizes.s50,
                    height: Sizes.s15,
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.s15),
                          ),
                        ),
                        width: Sizes.s40,
                        height: Sizes.s15,
                      ),
                      SizedBox(
                        height: Sizes.s5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.s15),
                          ),
                        ),
                        width: Sizes.s60,
                        height: Sizes.s10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Used at HotelListUIV2
class HotelListCardV2 extends StatelessWidget {
  final Hotel hotel;
  final Function onTap;
  HotelListCardV2({this.hotel, this.onTap});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    // init currency
    String currency = userCurrency(context);
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(bottom: Sizes.s20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.s15),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/misc/placeholder.png",
                image: "${hotel.thumbnail}",
                fit: BoxFit.cover,
                height: Sizes.s180,
                width: double.maxFinite,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                Sizes.s10,
                Sizes.s15,
                Sizes.s10,
                Sizes.s15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${hotel.name}",
                    style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${hotel.fullLocation}",
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: Sizes.s5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: Theme.of(context).textTheme.subtitle1,
                          children: <TextSpan>[
                            TextSpan(
                              text: '$currency',
                              style: TextStyle(
                                fontSize: Sizes.s12,
                              ),
                            ),
                            TextSpan(
                              text: "${hotel.price}",
                              style: TextStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Sizes.s5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: Theme.of(context).textTheme.subtitle1,
                          children: <TextSpan>[
                            TextSpan(
                              text: '$currency',
                              style: TextStyle(
                                fontSize: Sizes.s10,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                            TextSpan(
                              text: "${hotel.discountPrice}",
                              style: TextStyle(
                                fontSize: FontSize.s14,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Sizes.s10,
                      ),
                      Text(
                        "${hotel.discountText}",
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          RatingsValue(rating: "${hotel.rating}"),
                          Text(
                            "${hotel.reviews.length} ${lang.translate('widget.card.reviewLabel')}",
                            style: TextStyle(
                              fontSize: FontSize.s10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Used at HotelListUIV2
class HotelListLoaderV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: Sizes.s20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.s15),
        ),
      ),
      child: Container(
        width: double.maxFinite,
        child: Shimmer.fromColors(
          enabled: true,
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Sizes.s180,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(Sizes.s15),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    Sizes.s10,
                    Sizes.s15,
                    Sizes.s10,
                    Sizes.s15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Sizes.s15,
                        width: Sizes.s250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.s15),
                          ),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: Sizes.s10),
                      ),
                      Container(
                        height: Sizes.s15,
                        width: Sizes.s100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.s15),
                          ),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: Sizes.s10),
                      ),
                      Row(
                        children: [
                          Container(
                            height: Sizes.s15,
                            width: Sizes.s200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.s15),
                              ),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(bottom: Sizes.s15),
                          ),
                          Spacer(),
                          Container(
                            height: Sizes.s15,
                            width: Sizes.s40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.s15),
                              ),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(bottom: Sizes.s15),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Used at DetailUI
class TravelDetailCard extends StatelessWidget {
  final Function onTap;
  final String title;
  final String textTitle;
  final String textSubtitle;

  TravelDetailCard({
    this.onTap,
    this.title,
    this.textTitle,
    this.textSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(Sizes.s10),
          width: Sizes.s100,
          height: Sizes.s90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$title",
                style: TextStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(),
              Spacer(),
              Text(
                "$textTitle",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: FontSize.s12,
                ),
              ),
              Text(
                "$textSubtitle",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: FontSize.s10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Used at DetailUI
class HotelRoomCard extends StatelessWidget {
  final Rooms room;
  final Function onTapInfo;
  final Function onTapBooking;

  HotelRoomCard({
    @required this.room,
    @required this.onTapInfo,
    @required this.onTapBooking,
  });

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.s15),
        ),
      ),
      margin: EdgeInsets.only(bottom: Sizes.s20),
      padding: EdgeInsets.all(Sizes.s10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: onTapInfo,
            child: Container(
              height: Sizes.s120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      // topLeft: Radius.circular(Sizes.s15),
                      // bottomLeft: Radius.circular(Sizes.s15),
                      Radius.circular(Sizes.s15),
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/misc/placeholder.png",
                      image: "${room.thumbnail}",
                      fit: BoxFit.cover,
                      width: Sizes.s100,
                      height: Sizes.s100,
                    ),
                  ),
                  SizedBox(
                    width: Sizes.s10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${room.name}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.info,
                              size: Sizes.s25,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(height: Sizes.s10),
                        CustomChip(
                          title: "4 Room(s) left",
                          color: Colors.orange.withOpacity(.8),
                        ),
                        SizedBox(height: Sizes.s10),
                        Row(
                          children: <Widget>[
                            Icon(
                              FlutterIcons.bed_empty_mco,
                              size: FontSize.s14,
                            ),
                            SizedBox(
                              width: Sizes.s8,
                            ),
                            Text(
                              "${room.bed}",
                              style: TextStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Spacer()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.s15),
              ),
              boxShadow: [
                customShadow(),
              ],
            ),
            child: Container(
              margin: EdgeInsets.all(Sizes.s10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextCurrencyDiscount(price: "${room.discountPrice}"),
                      Text(
                        "${room.discountText}",
                        style: TextStyle(
                          fontSize: FontSize.s10,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextCurrency(price: "${room.price}")
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("${lang.translate('screen.room.onlyRoom')}"),
                      SizedBox(height: Sizes.s5),
                      Container(
                        height: Sizes.s30,
                        width: Sizes.s100,
                        child: GradientButton(
                          title: "${lang.translate('screen.room.bookButton')}",
                          onTap: onTapBooking,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Used at DetailUI
class RelatedHotelCard extends StatelessWidget {
  final Hotel hotel;
  final Function onTap;
  RelatedHotelCard({@required this.hotel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Sizes.s200,
        width: Sizes.s180,
        margin: EdgeInsets.only(bottom: Sizes.s15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s15),
          ),
          boxShadow: [
            customShadow(),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: Sizes.s100,
              width: Sizes.s180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "${hotel.thumbnail}",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Sizes.s15),
                  topRight: Radius.circular(Sizes.s15),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(Sizes.s10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${hotel.name}",
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    "${hotel.location}",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: FontSize.s12,
                    ),
                  ),
                  SizedBox(height: Sizes.s10),
                  Row(
                    children: <Widget>[
                      TextCurrency(price: "${hotel.price}"),
                      SizedBox(width: Sizes.s10),
                      TextCurrencyDiscount(price: "${hotel.discountPrice}"),
                    ],
                  ),
                  SizedBox(
                    height: Sizes.s5,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "${hotel.discountText}",
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: FontSize.s10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      RatingsValue(rating: "${hotel.rating}"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Used at ReviewsUI
class RatingsCard extends StatelessWidget {
  final double fiveStarValue;
  final double fourStarValue;
  final double threeStarValue;
  final double twoStarValue;
  final double oneStarValue;
  final double averageRating;
  final int totalReviews;

  RatingsCard({
    this.fiveStarValue = 0,
    this.fourStarValue = 0,
    this.threeStarValue = 0,
    this.twoStarValue = 0,
    this.oneStarValue = 0,
    this.averageRating = 0,
    this.totalReviews = 0,
  });

  // card color for average ratings
  Color averageColor() {
    if (averageRating >= 4) {
      return Colors.green;
    } else if (averageRating < 4 && averageRating >= 3) {
      return Colors.orange;
    } else {
      return Colors.redAccent;
    }
  }

  // card text for average ratings
  String averageText(context) {
    var lang = AppLocalizations.of(context);
    if (averageRating >= 4.5) {
      return "${lang.translate('widget.ratings.5stars')}";
    } else if (averageRating < 4.5 && averageRating >= 4) {
      return "${lang.translate('widget.ratings.4stars')}";
    } else if (averageRating < 4 && averageRating >= 3) {
      return "${lang.translate('widget.ratings.3stars')}";
    } else if (averageRating < 3 && averageRating >= 2) {
      return "${lang.translate('widget.ratings.2stars')}";
    } else {
      return "${lang.translate('widget.ratings.1star')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var lang = AppLocalizations.of(context);
    return Container(
      height: Sizes.s110,
      width: _width - Sizes.s30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RatingWrapper(
                  rating: "5",
                  title: "${lang.translate('widget.ratings.5stars')}",
                  value: fiveStarValue,
                  percent: "${(fiveStarValue * 100).floor()}%",
                ),
                RatingWrapper(
                  rating: "4",
                  title: "${lang.translate('widget.ratings.4stars')}",
                  value: fourStarValue,
                  percent: "${(fourStarValue * 100).floor()}%",
                ),
                RatingWrapper(
                  rating: "3",
                  title: "${lang.translate('widget.ratings.3stars')}",
                  value: threeStarValue,
                  percent: "${(threeStarValue * 100).floor()}%",
                ),
                RatingWrapper(
                  rating: "2",
                  title: "${lang.translate('widget.ratings.2stars')}",
                  value: twoStarValue,
                  percent: "${(twoStarValue * 100).floor()}%",
                ),
                RatingWrapper(
                  rating: "1",
                  title: "${lang.translate('widget.ratings.1star')}",
                  value: oneStarValue,
                  percent: "${(oneStarValue * 100).floor()}%",
                ),
              ],
            ),
          ),
          SizedBox(
            width: Sizes.s10,
          ),
          Container(
            width: 1,
            color: Colors.grey.withOpacity(.5),
          ),
          Container(
            height: Sizes.s80,
            margin: EdgeInsets.only(left: Sizes.s10, right: Sizes.s5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.s10),
              ),
              boxShadow: [
                customShadow(),
              ],
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: averageColor(),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Sizes.s10),
                      topLeft: Radius.circular(Sizes.s10),
                    ),
                  ),
                  width: Sizes.s70,
                  height: Sizes.s40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "$averageRating/5",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.s12,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${averageText(context)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s10,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(Sizes.s10),
                      bottomLeft: Radius.circular(Sizes.s10),
                    ),
                  ),
                  width: Sizes.s70,
                  height: Sizes.s40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "$totalReviews",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      Text(
                        "Reviews",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s10,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Used at WalletUI
class WalletHistoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String cash;
  final String date;
  final Color cashColor;

  WalletHistoryCard({
    this.title,
    this.subtitle,
    this.cash,
    this.date,
    this.cashColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: Sizes.s15),
      child: Container(
        margin: EdgeInsets.all(Sizes.s15),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$title",
                    style: TextStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "$subtitle",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "$cash",
                  style: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeight.w500,
                    color: cashColor ?? Colors.grey,
                  ),
                ),
                Text(
                  "$date",
                  style: TextStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.s15),
            ),
          ),
          height: Sizes.s100,
          width: Sizes.s100,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.s15),
            ),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/misc/placeholder.png",
              image:
                  "https://pix10.agoda.net/hotelImages/176968/-1/4b66733cc05d6d6883ba4498a9815f8f.jpg?s=1024x768",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: Sizes.s15,
        ),
        Divider(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Lorem Hotel Sit Amet Lorem Hotel Sit Amet Lorem Hotel Sit Amet",
                style: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Sizes.s5),
              Text(
                "John Doe",
                style: TextStyle(
                  fontSize: FontSize.s12,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "22 - 24 August, 2020",
                style: TextStyle(
                  fontSize: FontSize.s12,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "2 Rooms / 4 Guests",
                style: TextStyle(
                  fontSize: FontSize.s12,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Sizes.s5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RatingsValue(rating: "4,7"),
                  Spacer(),
                  Text("Book Again")
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

// Used at BookingUI
class BookingHistoryCard extends StatelessWidget {
  final BookingHistory history;
  BookingHistoryCard({@required this.history});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.s15),
                ),
              ),
              height: Sizes.s100,
              width: Sizes.s100,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(Sizes.s15),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/misc/placeholder.png",
                  image: "${history.thumbnail}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: Sizes.s15,
            ),
            Divider(),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${history.hotel}",
                    style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Sizes.s5),
                  Text(
                    "${history.guestName}",
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${history.bookingDate}",
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${history.room} ${lang.translate('widget.card.rooms')} / ${history.guest} ${lang.translate('widget.card.guests')}",
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Sizes.s5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RatingsValue(rating: "${history.rating}"),
                      Spacer(),
                      Text("${lang.translate('widget.card.bookAgain')}")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: Sizes.s10),
        Divider(),
        SizedBox(height: Sizes.s20)
      ],
    );
  }
}

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/models/HotelModel.dart';
import 'package:hotel_ui_kit/src/screens/payment/PaymentUI.dart';
import 'package:hotel_ui_kit/src/screens/photoviewer/PhotoViewer.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/common_widgets.dart';
import 'package:hotel_ui_kit/src/widgets/text_currency.dart';

class RoomDetailUI extends StatefulWidget {
  final Rooms room;
  RoomDetailUI({@required this.room});

  @override
  _RoomDetailUIState createState() => _RoomDetailUIState();
}

class _RoomDetailUIState extends State<RoomDetailUI> {
  List<Pictures> pictures = [];

  convertPictures() {
    widget.room.pictures.forEach((item) {
      pictures.add(Pictures(url: item, caption: widget.room.name));
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    convertPictures();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.room.name}"),
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: Sizes.s250,
                child: Carousel(
                  images: widget.room.pictures
                      .map(
                        (item) => InkWell(
                          onTap: () => openPage(
                            context,
                            PhotoViewer(
                              pictures: pictures,
                            ),
                          ),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/misc/placeholder.png",
                            image: item,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                  dotSize: Sizes.s4,
                  dotSpacing: Sizes.s15,
                  dotColor: primaryColor,
                  indicatorBgPadding: Sizes.s5,
                  borderRadius: true,
                  autoplay: false,
                  dotBgColor: Colors.transparent,
                  radius: Radius.circular(0),
                ),
              ),
              SizedBox(height: Sizes.s10),
              Container(
                padding: EdgeInsets.only(left: Sizes.s10, right: Sizes.s10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleIconWrapper(
                      title: "${lang.translate('screen.room.bed')}",
                      icon: FlutterIcons.bed_empty_mco,
                    ),
                    Text(widget.room.bed)
                  ],
                ),
              ),
              SizedBox(height: Sizes.s20),
              Container(
                padding: EdgeInsets.only(left: Sizes.s10, right: Sizes.s10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleIconWrapper(
                      title: "${lang.translate('screen.room.description')}",
                      icon: FlutterIcons.description_mdi,
                    ),
                    Text(
                      widget.room.description,
                      style: TextStyle(
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Sizes.s20),
              Container(
                padding: EdgeInsets.only(left: Sizes.s10, right: Sizes.s10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleIconWrapper(
                      title: "${lang.translate('screen.room.facility')}",
                      icon: FlutterIcons.shower_faw5s,
                    ),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.room.facilities.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3.5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        String facility = widget.room.facilities[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.check),
                            SizedBox(
                              width: Sizes.s5,
                            ),
                            Flexible(
                              child: Text(facility),
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: Sizes.s20),
              Card(
                margin: EdgeInsets.only(left: Sizes.s10, right: Sizes.s10),
                child: Container(
                  margin: EdgeInsets.all(Sizes.s10),
                  width: double.maxFinite,
                  // height: Sizes.s100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextCurrencyDiscount(
                              price: "${widget.room.discountPrice}"),
                          Text(
                            "${widget.room.discountText}",
                            style: TextStyle(
                              fontSize: FontSize.s10,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextCurrency(price: "${widget.room.price}")
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
                              title:
                                  "${lang.translate('screen.room.bookButton')}",
                              onTap: () => openPage(context, PaymentUI()),
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
        ),
      ),
    );
  }
}

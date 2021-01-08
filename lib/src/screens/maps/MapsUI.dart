import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/utils/themes.dart';
import 'package:hotel_ui_kit/src/models/HotelModel.dart';
import 'package:hotel_ui_kit/src/screens/detail/DetailUI.dart';
import 'package:hotel_ui_kit/src/services/local_service.dart';
import 'package:hotel_ui_kit/src/services/prefs_service.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/text_currency.dart';
import 'package:latlong/latlong.dart' as latLng;

class MapsUI extends StatefulWidget {
  @override
  _MapsUIState createState() => _MapsUIState();
}

class _MapsUIState extends State<MapsUI> {
  final MapController mapCtrl = MapController();
  List<Marker> markers = List<Marker>();
  List<Hotel> _hotels = [];
  bool _loaded = false;
  MapOptions mapOptions = MapOptions(
    center: latLng.LatLng(40.2085, -3.713),
    zoom: 5.0,
  );
  String mapType = "streets-v11";
  CarouselController controller = CarouselController();

  fetchHotels() async {
    final sharedPrefService = await SharedPreferencesService.instance;
    final isDarkModeEnabled = sharedPrefService.isDarkModeEnabled;
    await LocalService.loadHotels(false).then((value) {
      _hotels = value;
      value.forEach((element) {
        markers.add(
          Marker(
            width: Sizes.s90,
            height: Sizes.s90,
            point: latLng.LatLng(element.latitude, element.longitude),
            builder: (ctx) => InkWell(
                onTap: () {
                  controller.animateToPage(_hotels.indexOf(element));
                },
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: Sizes.s10,
                        width: Sizes.s10,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: Sizes.s3),
                      Container(
                        height: Sizes.s15,
                        width: Sizes.s40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.s20),
                          ),
                          boxShadow: [customShadow()],
                        ),
                        child: Center(
                          child: TextCurrency(
                            price: "${element.price}",
                            symbolSize: 5,
                            priceSize: FontSize.s8,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        );
      });
      setState(() {
        _loaded = true;
        mapType = isDarkModeEnabled ? "dark-v10" : "streets-v11";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHotels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(
          child: _loaded
              ? Stack(
                  children: <Widget>[
                    FlutterMap(
                      mapController: mapCtrl,
                      options: mapOptions,
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              "https://api.mapbox.com/styles/v1/mapbox/$mapType/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoibnNldHlvIiwiYSI6ImNrZGxueWk1dzEwZmkyd3BmOTFtZ29weXYifQ.4y-M_tGzYUfmxQMiWlv2SQ",
                          additionalOptions: {
                            'accessToken':
                                'pk.eyJ1IjoiaW5vb3JleGkiLCJhIjoiY2p6OWozaW1qMXdvNzNvbTJqdzRnZTBkNCJ9.tnXHDq0_ZB_O8qA2m9k5iQ',
                            'id': 'mapbox.streets',
                          },
                        ),
                        MarkerLayerOptions(
                          markers: markers,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomBackButton(
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: Sizes.s40),
                        child: CarouselSlider(
                          carouselController: controller,
                          options: CarouselOptions(
                            height: Sizes.s200,
                            aspectRatio: 2.0,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: true,
                            initialPage: 0,
                            autoPlay: false,
                            onPageChanged: (int index, fun) {
                              mapCtrl.move(
                                  latLng.LatLng(_hotels[index].latitude,
                                      _hotels[index].longitude),
                                  5.0);
                            },
                          ),
                          items: _hotels
                              .map((item) => InkWell(
                                    onTap: () => openPage(
                                      context,
                                      DetailUI(hotel: item),
                                    ),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxHeight: Sizes.s150,
                                        maxWidth: Sizes.s300,
                                      ),
                                      width: double.maxFinite,
                                      height: Sizes.s150,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Sizes.s15),
                                        ),
                                      ),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    Radius.circular(Sizes.s15),
                                                topRight:
                                                    Radius.circular(Sizes.s15),
                                              ),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    "assets/images/misc/placeholder.png",
                                                image: item.thumbnail,
                                                height: Sizes.s120,
                                                width: double.maxFinite,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: Sizes.s10,
                                                top: Sizes.s5,
                                                right: Sizes.s10,
                                              ),
                                              child: Text(
                                                "${item.name}",
                                                style: TextStyle(
                                                  fontSize: FontSize.s15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: Sizes.s10,
                                                top: Sizes.s5,
                                                right: Sizes.s10,
                                              ),
                                              child: Text(
                                                "${item.fullLocation}",
                                                style: TextStyle(
                                                  fontSize: FontSize.s12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                )
              : CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class DrawTriangleShape extends CustomPainter {
  Paint painter;

  DrawTriangleShape() {
    painter = Paint()
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

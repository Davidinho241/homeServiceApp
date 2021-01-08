import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/models/HotelModel.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class PhotoViewer extends StatefulWidget {
  final List<Pictures> pictures;
  PhotoViewer({@required this.pictures});
  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.black,
        child: Center(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Container(
                    height: Sizes.s300,
                    width: double.maxFinite,
                    child: Carousel(
                      images: widget.pictures
                          .map(
                            (item) => FadeInImage.assetNetwork(
                              placeholder: "assets/images/misc/placeholder.png",
                              image: item.url,
                              fit: BoxFit.cover,
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
                      onImageChange: (val, valx) {
                        setState(() {
                          index = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Sizes.s20),
                    child: Text(
                      widget.pictures[index].caption,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: Sizes.s30),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
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

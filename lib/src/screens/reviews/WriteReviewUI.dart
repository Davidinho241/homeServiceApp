import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/modal.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/common_widgets.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WriteReviewUI extends StatefulWidget {
  @override
  _WriteReviewUIState createState() => _WriteReviewUIState();
}

class _WriteReviewUIState extends State<WriteReviewUI> {
  double rating = 0.0;
  TextEditingController _reviewCtrl = TextEditingController();
  bool isSubmitting = false;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("${lang.translate('screen.writeReviews.appBar')}"),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(Sizes.s15),
        width: double.maxFinite,
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                          style: TextStyle(
                            fontSize: FontSize.s12,
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Sizes.s5),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {
                            setState(() {
                              rating = v;
                            });
                          },
                          starCount: 5,
                          rating: rating,
                          size: Sizes.s30,
                          isReadOnly: false,
                          color: Colors.yellow[600],
                          borderColor: Colors.yellow[600],
                          spacing: 0.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: Sizes.s20),
              TitleIconWrapper(
                icon: FlutterIcons.comment_faw5,
                title: "${lang.translate('screen.writeReviews.title')}",
              ),
              SizedBox(height: Sizes.s15),
              Container(
                width: double.maxFinite,
                height: Sizes.s150,
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.only(left: Sizes.s10, right: Sizes.s10),
                    child: TextField(
                      maxLines: 5,
                      controller: _reviewCtrl,
                      decoration: InputDecoration(
                        hintText:
                            "${lang.translate('screen.writeReviews.hint')}",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Sizes.s30),
                height: Sizes.s50,
                child: isSubmitting
                    ? Center(child: CupertinoActivityIndicator())
                    : GradientButton(
                        title:
                            "${lang.translate('screen.writeReviews.button')}",
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return CustomModal.loading(
                                context,
                                "Sending Review..",
                              );
                            },
                          );
                          await Future.delayed(
                            Duration(milliseconds: 2500),
                            () {
                              Navigator.pop(context);
                            },
                          );
                          _reviewCtrl.clear();
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                "Rating : $rating, Comment : ${_reviewCtrl.text}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.black.withOpacity(.6),
                            ),
                          );
                          var data = {
                            "rating": rating,
                            "comment": _reviewCtrl.text,
                          };
                          print(data);
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

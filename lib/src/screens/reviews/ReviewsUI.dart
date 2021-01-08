import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/models/HotelModel.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/cards.dart';
import 'package:hotel_ui_kit/src/widgets/common_widgets.dart';

class ReviewsUI extends StatefulWidget {
  final List<Reviews> reviews;
  ReviewsUI({@required this.reviews});

  @override
  _ReviewsUIState createState() => _ReviewsUIState();
}

class _ReviewsUIState extends State<ReviewsUI> {
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("${lang.translate('screen.reviews.appBar')}"),
      ),
      body: Container(
        padding: EdgeInsets.all(Sizes.s15),
        width: double.maxFinite,
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleIconWrapper(
                icon: FlutterIcons.star_ant,
                title: "${lang.translate('screen.reviews.ratings')}",
              ),
              Divider(),
              SizedBox(
                height: Sizes.s10,
              ),
              RatingsCard(
                fiveStarValue: .8,
                fourStarValue: .7,
                threeStarValue: .2,
                twoStarValue: .2,
                oneStarValue: .1,
                totalReviews: widget.reviews.length,
                averageRating: 4,
              ),
              SizedBox(
                height: Sizes.s20,
              ),
              TitleIconWrapper(
                icon: FlutterIcons.comment_account_mco,
                title: "${lang.translate('screen.reviews.allReviews')}",
              ),
              Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.reviews.length,
                itemBuilder: (context, index) {
                  Reviews review = widget.reviews[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ReviewWrapper(
                        review: review,
                        onReport: (String val) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                val == "spam"
                                    ? "${lang.translate('screen.reviews.spam')}"
                                    : "${lang.translate('screen.reviews.inappropriate')}",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor:
                                  Colors.grey[900].withOpacity(.85),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: Sizes.s25),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

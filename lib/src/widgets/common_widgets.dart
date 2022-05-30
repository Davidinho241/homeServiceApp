import 'package:flutter/material.dart';
import 'package:home_service/src/utils/themes.dart';
import 'package:home_service/src/models/HotelModel.dart';
import 'package:home_service/src/utils/colors.dart';
import 'package:home_service/src/utils/sizes.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

// Used in Filter UI & Home UI
class TitleWrapper extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool showButton;

  TitleWrapper({
    @required this.title,
    @required this.onTap,
    this.showButton = true,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Sizes.s20, right: Sizes.s20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(
              fontSize: FontSize.s15,
              fontWeight: FontWeight.w600,
            ),
          ),
          showButton
              ? InkWell(
                  onTap: onTap,
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: FontSize.s13,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

// Used in Detail UI, Reviews UI, Room Detail, Write Reveiw
class TitleIconWrapper extends StatelessWidget {
  final IconData icon;
  final String title;
  TitleIconWrapper({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          icon,
          size: FontSize.s15,
        ),
        SizedBox(
          width: Sizes.s6,
        ),
        Text(
          "$title",
          style: TextStyle(
            fontSize: FontSize.s16,
          ),
        )
      ],
    );
  }
}

// Used at Detail UI
class CustomMarkdown extends StatelessWidget {
  final IconData icon;
  final Widget title;
  CustomMarkdown({@required this.icon, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: FontSize.s8,
        ),
        SizedBox(
          width: Sizes.s10,
        ),
        Flexible(
          child: title,
        )
      ],
    );
  }
}

// Used at RatingWrapper
class RatingProgress extends StatelessWidget {
  final double value;
  RatingProgress({@required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s10,
      width: double.maxFinite,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.s10)),
        child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          value: value,
        ),
      ),
    );
  }
}

// Used at RatingsCard
class RatingWrapper extends StatelessWidget {
  final String rating;
  final String title;
  final double value;
  final String percent;

  RatingWrapper({
    @required this.rating,
    @required this.title,
    @required this.value,
    @required this.percent,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: Sizes.s120,
          margin: EdgeInsets.only(right: Sizes.s5),
          child: Row(
            children: <Widget>[
              Text(
                "$rating",
                style: TextStyle(
                  fontSize: FontSize.s12,
                ),
              ),
              SizedBox(
                width: Sizes.s5,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: FontSize.s12,
              ),
              SizedBox(
                width: Sizes.s5,
              ),
              Text(
                "$title",
                style: TextStyle(
                  fontSize: FontSize.s12,
                ),
              ),
              SizedBox(
                width: Sizes.s5,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: RatingProgress(
            value: value,
          ),
        ),
        SizedBox(
          width: Sizes.s5,
        ),
        Container(
          width: Sizes.s30,
          child: Text(
            "$percent",
            style: TextStyle(
              fontSize: FontSize.s12,
            ),
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }
}

// Used in Detail UI & Reviews UI
class ReviewWrapper extends StatelessWidget {
  final Reviews review;
  final Function(String) onReport;

  ReviewWrapper({@required this.review, this.onReport});
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/LL/yy');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Sizes.s30,
              height: Sizes.s30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    "${review.avatar}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: Sizes.s10,
            ),
            Text(
              "${review.name}",
              style: TextStyle(
                fontSize: FontSize.s14,
              ),
            ),
            Spacer(),
            Container(
              constraints: BoxConstraints(
                maxHeight: Sizes.s20,
                maxWidth: Sizes.s20,
              ),
              child: PopupMenuButton(
                padding: EdgeInsets.zero,
                elevation: 0,
                icon: Icon(
                  Icons.more_vert,
                  size: FontSize.s15,
                ),
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: "inappropriate",
                    child: Text('Report as inappropriate'),
                  ),
                  PopupMenuItem<String>(
                    value: "spam",
                    child: Text('Report as spam'),
                  ),
                ],
                onSelected: onReport,
              ),
            )
          ],
        ),
        SizedBox(
          height: Sizes.s5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SmoothStarRating(
              allowHalfRating: false,
              onRated: (v) {},
              starCount: 5,
              rating: review.rating.toDouble(),
              size: Sizes.s20,
              isReadOnly: true,
              color: Colors.yellow,
              borderColor: Colors.yellow,
              spacing: 0.0,
            ),
            SizedBox(width: Sizes.s10),
            Text(
              dateFormat.format(DateTime.parse(review.createdAt)),
              style: TextStyle(
                fontSize: FontSize.s12,
                color: Colors.grey,
              ),
            )
          ],
        ),
        SizedBox(
          height: Sizes.s5,
        ),
        Text(review.comment),
      ],
    );
  }
}

// Used at Payment UI
class StepperNumber extends StatelessWidget {
  final String number;
  final bool active;

  StepperNumber({
    @required this.number,
    @required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.s30,
      height: Sizes.s30,
      decoration: BoxDecoration(
        color: active ? null : Colors.grey,
        shape: BoxShape.circle,
        gradient: active ? customGradient() : null,
      ),
      child: Center(
        child: Text(
          "$number",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// Used at Payment Details
class TextRowDetails extends StatelessWidget {
  final String title;
  final String content;

  TextRowDetails({@required this.title, @required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizes.s15),
      child: Row(
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(
              fontSize: FontSize.s14,
            ),
          ),
          Spacer(),
          Text(
            "$content",
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.s14,
            ),
          )
        ],
      ),
    );
  }
}

// Used at Account UI
class AccountTile extends StatelessWidget {
  final IconData icons;
  final String title;
  final Function onTap;

  AccountTile({
    @required this.icons,
    @required this.title,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: Sizes.s10),
        height: Sizes.s50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey.withOpacity(.5),
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icons,
              size: FontSize.s18,
              color: Colors.grey,
            ),
            SizedBox(
              width: Sizes.s10,
            ),
            Text(
              "$title",
              style: TextStyle(
                fontSize: FontSize.s16,
              ),
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

// Ratings value
class RatingsValue extends StatelessWidget {
  final String rating;
  RatingsValue({@required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellow[600],
          size: FontSize.s14,
        ),
        Container(width: 5),
        Center(
          child: Text(
            "$rating",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.s12,
            ),
          ),
        )
      ],
    );
  }
}

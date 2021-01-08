import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/utils/themes.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

// Create gradient button
class GradientButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final double fontSize;
  GradientButton({
    @required this.title,
    @required this.onTap,
    this.fontSize = 12,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          Sizes.s10,
          Sizes.s5,
          Sizes.s10,
          Sizes.s5,
        ),
        decoration: BoxDecoration(
          // custom gradient color, you can customize this
          gradient: customGradient(),
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s5),
          ),
        ),
        child: Center(
          child: Text(
            "$title",
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}

// Used in Login & Register
class ButtonWithIcon extends StatelessWidget {
  final String title;
  final double height;
  final Function onTap;
  final IconData icon;
  final Color color;
  ButtonWithIcon({
    @required this.title,
    this.height,
    @required this.onTap,
    @required this.icon,
    @required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height != null ? height : Sizes.s40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s10),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: FontSize.s15,
              color: Colors.white,
            ),
            SizedBox(
              width: Sizes.s5,
            ),
            Text(
              "$title",
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.s15,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Used at Maps UI
class CustomBackButton extends StatelessWidget {
  final Function onTap;
  final bool enableMargin;
  CustomBackButton({@required this.onTap, this.enableMargin = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: enableMargin
          ? EdgeInsets.only(top: Sizes.s50, left: Sizes.s20)
          : EdgeInsets.zero,
      width: Sizes.s40,
      height: Sizes.s40,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.s40),
        ),
        boxShadow: [
          customShadow(),
        ],
      ),
      child: Center(
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}

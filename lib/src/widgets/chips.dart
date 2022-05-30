import 'package:flutter/material.dart';
import 'package:home_service/src/utils/sizes.dart';

// Used at DetailUI & Cards
class CustomChip extends StatelessWidget {
  final String title;
  final Color color;
  CustomChip({this.title, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.s15),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        Sizes.s10,
        Sizes.s5,
        Sizes.s10,
        Sizes.s5,
      ),
      child: Text(
        "$title",
        style: TextStyle(
          color: Colors.white,
          fontSize: FontSize.s12,
        ),
      ),
    );
  }
}

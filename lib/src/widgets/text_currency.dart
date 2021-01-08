import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/currency.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class TextCurrency extends StatelessWidget {
  final String price;
  final double symbolSize;
  final double priceSize;
  TextCurrency({@required this.price, this.symbolSize, this.priceSize});

  @override
  Widget build(BuildContext context) {
    // init currency
    String currency = userCurrency(context);
    return RichText(
      text: TextSpan(
        text: '',
        style: Theme.of(context).textTheme.subtitle1,
        children: <TextSpan>[
          TextSpan(
            text: '$currency',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: symbolSize ?? FontSize.s10,
            ),
          ),
          TextSpan(
            text: "$price",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: priceSize ?? FontSize.s15,
            ),
          ),
        ],
      ),
    );
  }
}

class TextCurrencyDiscount extends StatelessWidget {
  final String price;
  TextCurrencyDiscount({@required this.price});
  @override
  Widget build(BuildContext context) {
    // init currency
    String currency = userCurrency(context);
    return RichText(
      text: TextSpan(
        text: '',
        style: Theme.of(context).textTheme.subtitle1,
        children: <TextSpan>[
          TextSpan(
            text: '$currency',
            style: TextStyle(
              fontSize: Sizes.s8,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
          TextSpan(
            text: "$price",
            style: TextStyle(
              fontSize: FontSize.s12,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class CustomCreditCardForm extends StatefulWidget {
  const CustomCreditCardForm({
    Key key,
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    @required this.onCreditCardModelChange,
  }) : super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final void Function(CreditCardModel) onCreditCardModelChange;

  @override
  _CustomCreditCardFormState createState() => _CustomCreditCardFormState();
}

class _CustomCreditCardFormState extends State<CustomCreditCardForm> {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool isCvvFocused = false;
  Color themeColor;

  void Function(CreditCardModel) onCreditCardModelChange;
  CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber ?? '';
    expiryDate = widget.expiryDate ?? '';
    cardHolderName = widget.cardHolderName ?? '';
    cvvCode = widget.cvvCode ?? '';

    creditCardModel = CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Form(
      child: Column(
        children: <Widget>[
          Container(
            height: Sizes.s50,
            margin: EdgeInsets.only(top: Sizes.s30),
            child: TextFormField(
              controller: _cardNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Sizes.s10)),
                  borderSide: BorderSide(width: 1, color: Colors.grey[100]),
                ),
                labelText:
                    "${lang.translate('screen.payments.cardNumberLabel')}",
                hintText: "${lang.translate('screen.payments.cardNumberHint')}",
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
          ),
          Container(
            height: Sizes.s50,
            margin: EdgeInsets.only(top: Sizes.s30),
            child: TextFormField(
              controller: _expiryDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Sizes.s10)),
                  borderSide: BorderSide(width: 1, color: Colors.grey[100]),
                ),
                labelText: "${lang.translate('screen.payments.expiredDateLabel')}",
                hintText: "${lang.translate('screen.payments.expiredDateHint')}",
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
          ),
          Container(
            height: Sizes.s50,
            margin: EdgeInsets.only(top: Sizes.s30),
            child: TextField(
              focusNode: cvvFocusNode,
              controller: _cvvCodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Sizes.s10)),
                  borderSide: BorderSide(width: 1, color: Colors.grey[100]),
                ),
                labelText: "${lang.translate('screen.payments.cvvLabel')}",
                hintText: "${lang.translate('screen.payments.cvvHint')}",
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (String text) {
                setState(() {
                  cvvCode = text;
                });
              },
            ),
          ),
          Container(
            height: Sizes.s50,
            margin: EdgeInsets.only(top: Sizes.s30),
            child: TextFormField(
              controller: _cardHolderNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Sizes.s10)),
                  borderSide: BorderSide(width: 1, color: Colors.grey[100]),
                ),
                labelText: "${lang.translate('screen.payments.cardHolderLabel')}",
                hintText: "${lang.translate('screen.payments.cardHolderHint')}",
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }
}

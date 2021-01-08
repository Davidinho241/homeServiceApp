import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/modal.dart';
import 'package:hotel_ui_kit/src/helpers/toast.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/credit_card_field.dart';

class PaymentInformationUI extends StatefulWidget {
  @override
  _PaymentInformationUIState createState() => _PaymentInformationUIState();
}

class _PaymentInformationUIState extends State<PaymentInformationUI> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  // cc
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = true;
  // end

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Widget _paymentInformation() {
    var lang = AppLocalizations.of(context);
    return Column(
      children: <Widget>[
        CreditCardWidget(
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          showBackView: isCvvFocused,
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: CustomCreditCardForm(
              onCreditCardModelChange: onCreditCardModelChange,
            ),
          ),
        ),
        MediaQuery.of(context).viewInsets.bottom == 0
            ? Container(
                height: Sizes.s50,
                margin: EdgeInsets.only(bottom: Sizes.s15),
                child: GradientButton(
                  title: "${lang.translate('screen.payments.saveButton')}",
                  onTap: () async {
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isDismissible: false,
                      builder: (BuildContext context) {
                        return CustomModal.loading(
                          context,
                          "Saving Payment Information..",
                        );
                      },
                    );
                    await Future.delayed(
                      Duration(milliseconds: 2500),
                      () => Navigator.pop(context),
                    );
                    showToast(
                      _scaffoldKey,
                      "Payment Information Saved Successfuly",
                    );
                  },
                ),
              )
            : Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("${lang.translate('screen.payments.appBar')}"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: EdgeInsets.all(Sizes.s15),
        child: _paymentInformation(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:hotel_ui_kit/src/helpers/currency.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/modal.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/screens/payment_success/PaymentSuccessUI.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/common_widgets.dart';
import 'package:hotel_ui_kit/src/widgets/credit_card_field.dart';
import 'package:hotel_ui_kit/src/widgets/inputs.dart';

class PaymentUI extends StatefulWidget {
  @override
  _PaymentUIState createState() => _PaymentUIState();
}

class _PaymentUIState extends State<PaymentUI> {
  int index = 0;
  PageController controller = PageController();

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

  Widget _bookingDetails() {
    var lang = AppLocalizations.of(context);
    // init currency
    String currency = userCurrency(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
                    RatingsValue(rating: "4,7"),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: Sizes.s20),
          Text(
            "${lang.translate('screen.hotelPayment.details')}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.s14,
            ),
          ),
          Divider(),
          SizedBox(height: Sizes.s10),
          TextRowDetails(
            title:
                "${lang.translate('screen.hotelPayment.checkIn')} - ${lang.translate('screen.hotelPayment.checkOut')}",
            content: "20 - 22 Aug, 2020",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.rooms')}",
            content: "2 ${lang.translate('screen.hotelPayment.rooms')}",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.guests')}",
            content: "4 ${lang.translate('screen.hotelPayment.guests')}",
          ),
          SizedBox(height: Sizes.s20),
          Text(
            "${lang.translate('screen.hotelPayment.taxFees')}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.s14,
            ),
          ),
          Divider(),
          TextRowDetails(
            title:
                "${currency}10 x 2 ${lang.translate('screen.hotelPayment.nights')}",
            content: "${currency}20",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.fee1')}",
            content: "${currency}35",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.fee2')}",
            content: "${currency}25",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.tax')}",
            content: "${currency}10",
          ),
          Row(
            children: <Widget>[
              Text(
                "${lang.translate('screen.hotelPayment.total')}",
                style: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                "${currency}90",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.s14,
                    color: primaryColor),
              )
            ],
          ),
          Container(
            height: Sizes.s50,
            margin: EdgeInsets.only(bottom: Sizes.s15, top: Sizes.s25),
            child: GradientButton(
              title:
                  "${lang.translate('screen.hotelPayment.goToPersonalInfo')}",
              onTap: () {
                controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _personalInformation() {
    var lang = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          OutlineTextField(
            hintText: "${lang.translate('screen.hotelPayment.firstNameHint')}",
            labelText:
                "${lang.translate('screen.hotelPayment.firstNameLabel')}",
            hintStyle: TextStyle(fontSize: FontSize.s14),
            labelStyle: TextStyle(fontSize: FontSize.s14),
          ),
          SizedBox(
            height: Sizes.s30,
          ),
          OutlineTextField(
            hintText: "${lang.translate('screen.hotelPayment.lastNameHint')}",
            labelText: "${lang.translate('screen.hotelPayment.lastNameLabel')}",
            hintStyle: TextStyle(fontSize: FontSize.s14),
            labelStyle: TextStyle(fontSize: FontSize.s14),
          ),
          SizedBox(
            height: Sizes.s30,
          ),
          OutlineTextField(
            hintText: "${lang.translate('screen.hotelPayment.emailHint')}",
            labelText: "${lang.translate('screen.hotelPayment.emailLabel')}",
            hintStyle: TextStyle(fontSize: FontSize.s14),
            labelStyle: TextStyle(fontSize: FontSize.s14),
          ),
          SizedBox(
            height: Sizes.s30,
          ),
          OutlineTextField(
            hintText: "${lang.translate('screen.hotelPayment.addressHint')}",
            labelText: "${lang.translate('screen.hotelPayment.addressLabel')}",
            hintStyle: TextStyle(fontSize: FontSize.s14),
            labelStyle: TextStyle(fontSize: FontSize.s14),
          ),
          SizedBox(
            height: Sizes.s30,
          ),
          OutlineTextField(
            hintText: "${lang.translate('screen.hotelPayment.postalHint')}",
            labelText: "${lang.translate('screen.hotelPayment.postalLabel')}",
            hintStyle: TextStyle(fontSize: FontSize.s14),
            labelStyle: TextStyle(fontSize: FontSize.s14),
          ),
          SizedBox(
            height: Sizes.s30,
          ),
          OutlineTextField(
            hintText: "${lang.translate('screen.hotelPayment.phoneHint')}",
            labelText: "${lang.translate('screen.hotelPayment.phoneLabel')}",
            hintStyle: TextStyle(fontSize: FontSize.s14),
            labelStyle: TextStyle(fontSize: FontSize.s14),
          ),
          // Spacer(),
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Container(
                  height: Sizes.s50,
                  margin: EdgeInsets.only(bottom: Sizes.s15, top: Sizes.s25),
                  child: GradientButton(
                    title:
                        "${lang.translate('screen.hotelPayment.goToPayment')}",
                    onTap: () {
                      controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _paymentInformation() {
    var lang = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
          ),
          CustomCreditCardForm(
            onCreditCardModelChange: onCreditCardModelChange,
          ),
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Container(
                  height: Sizes.s50,
                  margin: EdgeInsets.only(bottom: Sizes.s15, top: Sizes.s25),
                  child: GradientButton(
                    title:
                        "${lang.translate('screen.hotelPayment.goToConfirmation')}",
                    onTap: () {
                      controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _confirmation() {
    var lang = AppLocalizations.of(context);
    // init currency
    String currency = userCurrency(context);
    return SingleChildScrollView(
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
                    RatingsValue(rating: "4,7"),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: Sizes.s20),
          Text(
            "${lang.translate('screen.hotelPayment.details')}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.s14,
            ),
          ),
          Divider(),
          SizedBox(height: Sizes.s10),
          TextRowDetails(
            title:
                "${lang.translate('screen.hotelPayment.checkIn')} - ${lang.translate('screen.hotelPayment.checkOut')}",
            content: "20 - 22 Aug, 2020",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.rooms')}",
            content: "2 ${lang.translate('screen.hotelPayment.rooms')}",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.guests')}",
            content: "4 ${lang.translate('screen.hotelPayment.guests')}",
          ),
          SizedBox(height: Sizes.s20),
          Text(
            "${lang.translate('screen.hotelPayment.personalInfo')}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.s14,
            ),
          ),
          Divider(),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.guestName')}",
            content: "John Doe",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.email')}",
            content: "joh.doe@mail.com",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.phone')}",
            content: "(+1) 234-567-8910",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.address')}",
            content: "Lorem Ipsum Dolor Sit Address",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.postalCode')}",
            content: "63278",
          ),
          SizedBox(height: Sizes.s20),
          Text(
            "${lang.translate('screen.hotelPayment.paymentInfo')}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.s14,
            ),
          ),
          Divider(),
          SizedBox(height: Sizes.s10),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.cardHolder')}",
            content: "John Doe",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.cardNumber')}",
            content: "1234 5678 9101 2131",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.expiredDate')}",
            content: "04/22",
          ),
          SizedBox(height: Sizes.s20),
          Text(
            "${lang.translate('screen.hotelPayment.taxFees')}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.s14,
            ),
          ),
          Divider(),
          TextRowDetails(
            title:
                "${currency}10 x 2 ${lang.translate('screen.hotelPayment.nights')}",
            content: "${currency}20",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.fee1')}",
            content: "${currency}35",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.fee2')}",
            content: "${currency}25",
          ),
          TextRowDetails(
            title: "${lang.translate('screen.hotelPayment.tax')}",
            content: "${currency}10",
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                "${currency}90",
                style: TextStyle(
                  fontSize: FontSize.s20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            "${lang.translate('screen.hotelPayment.totalPayment')}"),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                "${lang.translate('screen.hotelPayment.totalPaymentInfo')}",
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                                "${lang.translate('screen.hotelPayment.okBtn')}"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            height: Sizes.s50,
            margin: EdgeInsets.only(bottom: Sizes.s15, top: Sizes.s25),
            child: GradientButton(
              title: "${lang.translate('screen.hotelPayment.confirm')}",
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isDismissible: false,
                  builder: (BuildContext context) {
                    return CustomModal.loading(
                      context,
                      "Processing Payment..",
                    );
                  },
                );
                Future.delayed(
                  Duration(milliseconds: 2500),
                  () {
                    Navigator.pop(context);
                    openPage(context, PaymentSuccessUI());
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.hotelPayment.appBar')}"),
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Sizes.s10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StepperNumber(
                  active: index >= 0 ? true : false,
                  number: "1",
                ),
                Container(
                  width: Sizes.s40,
                  color: index > 0 ? primaryColor : Colors.grey,
                  height: 1,
                ),
                StepperNumber(
                  active: index < 1 ? false : true,
                  number: "2",
                ),
                Container(
                  width: Sizes.s40,
                  color: index > 1 ? primaryColor : Colors.grey,
                  height: 1,
                ),
                StepperNumber(
                  active: index < 2 ? false : true,
                  number: "3",
                ),
                Container(
                  width: Sizes.s40,
                  color: index > 2 ? primaryColor : Colors.grey,
                  height: 1,
                ),
                StepperNumber(
                  active: index < 3 ? false : true,
                  number: "4",
                ),
              ],
            ),
            SizedBox(
              height: Sizes.s20,
            ),
            Expanded(
              flex: 1,
              child: PageView.builder(
                controller: controller,
                itemCount: 4,
                // physics: NeverScrollableScrollPhysics(),
                onPageChanged: (int val) {
                  setState(() {
                    index = val;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    padding: EdgeInsets.only(left: Sizes.s15, right: Sizes.s15),
                    child: SingleChildScrollView(
                      child: Container(
                        height: _height - Sizes.s165,
                        width: double.maxFinite,
                        child: index == 0
                            ? _bookingDetails()
                            : index == 1
                                ? _personalInformation()
                                : index == 2
                                    ? _paymentInformation()
                                    : _confirmation(),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

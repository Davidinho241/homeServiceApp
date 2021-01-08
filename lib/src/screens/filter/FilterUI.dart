import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/currency.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/common_widgets.dart';

class FilterUI extends StatefulWidget {
  @override
  _FilterUIState createState() => _FilterUIState();
}

class _FilterUIState extends State<FilterUI> {
  RangeValues _values = RangeValues(0.4, 0.8);
  List<String> tags = [];
  List<String> options = [
    'Parking',
    'Smoking',
    'TV',
    'Restaurant',
    'Wifi',
    'Air Conditioning',
    'Soundproof'
  ];
  List<String> addOns = [];
  List<String> addonsOpt = ['Breakfast', 'Late Checkout', 'Early Check In'];
  List<String> propertyTypes = ['All Type', 'Couple', 'Family', 'Business'];
  int _selectedType = 0;
  List<String> payments = ['All', 'Pay at Hotel'];
  int _selectedPayments = 0;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    // init currency
    String currency = userCurrency(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("${lang.translate('screen.filter.appBar')}"),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: Sizes.s20,
              ),
              Container(
                margin: EdgeInsets.only(left: Sizes.s20, right: Sizes.s20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${lang.translate('screen.filter.priceRange')}",
                      style: TextStyle(
                        fontSize: FontSize.s15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "$currency ${_values.start * 1000} - $currency ${_values.end * 1000}",
                    )
                  ],
                ),
              ),
              RangeSlider(
                values: _values,
                divisions: 10,
                onChanged: (RangeValues values) {
                  setState(() {
                    _values = values;
                  });
                },
              ),
              Divider(),
              TitleWrapper(
                title: "${lang.translate('screen.filter.facility')}",
                onTap: null,
                showButton: false,
              ),
              // ChipsChoice<T>.multiple
              ChipsChoice<String>.multiple(
                value: tags,
                options: ChipsChoiceOption.listFrom<String, String>(
                  source: options,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
                onChanged: (val) => setState(() => tags = val),
                isWrapped: true,
                itemConfig: ChipsChoiceItemConfig(selectedColor: primaryColor),
              ),
              Divider(),
              TitleWrapper(
                title: "${lang.translate('screen.filter.addOn')}",
                onTap: null,
                showButton: false,
              ),
              // ChipsChoice<T>.multiple
              ChipsChoice<String>.multiple(
                value: addOns,
                options: ChipsChoiceOption.listFrom<String, String>(
                  source: addonsOpt,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
                onChanged: (val) => setState(() => addOns = val),
                isWrapped: true,
                itemConfig: ChipsChoiceItemConfig(selectedColor: primaryColor),
              ),
              Divider(),
              TitleWrapper(
                title: "${lang.translate('screen.filter.propertyType')}",
                onTap: null,
                showButton: false,
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: Sizes.s20, right: Sizes.s20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: propertyTypes.length,
                itemBuilder: (context, index) {
                  return Material(
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        setState(() {
                          _selectedType = index;
                        });
                      },
                      title: Text("${propertyTypes[index]}"),
                      trailing: Radio(
                        value: index,
                        groupValue: _selectedType,
                        onChanged: (int val) {
                          setState(() {
                            _selectedType = val;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              Divider(),
              TitleWrapper(
                title: "${lang.translate('screen.filter.payment')}",
                onTap: null,
                showButton: false,
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: Sizes.s20, right: Sizes.s20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  return Material(
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        setState(() {
                          _selectedPayments = index;
                        });
                      },
                      title: Text("${payments[index]}"),
                      trailing: Radio(
                        value: index,
                        groupValue: _selectedPayments,
                        onChanged: (int val) {
                          setState(() {
                            _selectedPayments = val;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(left: Sizes.s20, right: Sizes.s20),
                height: Sizes.s40,
                child: GradientButton(
                  title: "${lang.translate('screen.filter.saveButton')}",
                  onTap: () => Navigator.pop(context),
                  fontSize: FontSize.s15,
                ),
              ),
              Container(
                height: Sizes.s40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

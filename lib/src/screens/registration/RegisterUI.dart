import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/modal.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/helpers/toast.dart';
import 'package:hotel_ui_kit/src/screens/dashboard/DashboardUI.dart';
import 'package:hotel_ui_kit/src/screens/login/LoginUI.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/inputs.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class RegisterUI extends StatefulWidget {
  @override
  _RegisterUIState createState() => _RegisterUIState();
}
enum Gender { Male, Female }

class _RegisterUIState extends State<RegisterUI> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  Gender _gender = Gender.Male;
  bool status = false;
  bool enable = true;

  List<String> citiesList = <String>[
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut'
  ];

  bool _obscurePassword = true;
  Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('237');

  Widget _buildDialogItem(Country country, {bool showCountryName = true}) =>
      Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8.0),
          showCountryName ? Flexible(child: Text(country.name)) : Container()
        ],
      );

  void _openFilteredCountryPickerDialog() => showDialog(
      context: context,
      builder: (context) {
        var lang = AppLocalizations.of(context);
        return Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(
              hintText: "${lang.translate('screen.register.searchPhoneHint')}",
            ),
            isSearchable: true,
            title: Text(
              "${lang.translate('screen.register.selectPhoneText')}",
            ),
            onValuePicked: (Country country) =>
                setState(() => _selectedFilteredDialogCountry = country),
            itemBuilder: _buildDialogItem,
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    final ThemeData mode = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("${lang.translate('screen.register.appBar')}"),
        elevation: 0,
        actions: <Widget>[
          FlatButton(
            color: Colors.transparent,
            onPressed: () => openRemovePage(context, DashboardUI()),
            child: Text(
              "${lang.translate('screen.register.skip')}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(Sizes.s15, Sizes.s15, Sizes.s15, 0),
        width: double.maxFinite,
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "${lang.translate('screen.register.title')}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.s20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "${lang.translate('screen.register.subtitle')}",
                  style: TextStyle(
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
              SizedBox(
                height: Sizes.s25,
              ),
              Image.asset(
                "assets/images/misc/receptionist.png",
                height: Sizes.s100,
              ),
              SizedBox(
                height: Sizes.s25,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlineTextField(
                      hintText:
                          "${lang.translate('screen.register.firstNameHint')}",
                      labelText:
                          "${lang.translate('screen.register.firstNameLabel')}",
                      hintStyle: TextStyle(fontSize: FontSize.s14),
                      labelStyle: TextStyle(fontSize: FontSize.s14),
                    ),
                  ),
                  SizedBox(
                    width: Sizes.s10,
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlineTextField(
                      hintText:
                          "${lang.translate('screen.register.lastNameHint')}",
                      labelText:
                          "${lang.translate('screen.register.lastNameLabel')}",
                      hintStyle: TextStyle(fontSize: FontSize.s14),
                      labelStyle: TextStyle(fontSize: FontSize.s14),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Sizes.s15,
              ),
              OutlineTextField(
                hintText: "${lang.translate('screen.register.emailHint')}",
                labelText: "${lang.translate('screen.register.emailLabel')}",
                hintStyle: TextStyle(fontSize: FontSize.s14),
                labelStyle: TextStyle(fontSize: FontSize.s14),
              ),
              SizedBox(
                height: Sizes.s15,
              ),
              OutlineTextField(
                obscureText: _obscurePassword,
                hintText: "${lang.translate('screen.register.passwordHint')}",
                labelText: "${lang.translate('screen.register.passwordLabel')}",
                hintStyle: TextStyle(fontSize: FontSize.s14),
                labelStyle: TextStyle(fontSize: FontSize.s14),
                suffixIcon: IconButton(
                  icon: _obscurePassword
                      ? Icon(FlutterIcons.eye_fea)
                      : Icon(FlutterIcons.eye_off_fea),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = _obscurePassword ? false : true;
                    });
                  },
                ),
              ),
              SizedBox(
                height: Sizes.s20,
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: _openFilteredCountryPickerDialog,
                    child: _buildDialogItem(
                      _selectedFilteredDialogCountry,
                      showCountryName: false,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlineTextField(
                      hintText:
                          "${lang.translate('screen.register.phoneHint')}",
                      labelText:
                          "${lang.translate('screen.register.phoneLabel')}",
                      hintStyle: TextStyle(fontSize: FontSize.s14),
                      labelStyle: TextStyle(fontSize: FontSize.s14),
                      textInputType: TextInputType.number,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Sizes.s20,
              ),
              Container(
                height: Sizes.s50,
                child:DropdownSearch<String>(
                  showSelectedItem: true,
                  items: citiesList,
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: print,
                  autoValidateMode: AutovalidateMode.always,
                  showSearchBox: true,
                  searchBoxDecoration: InputDecoration(
                    labelText: "${lang.translate('screen.register.selectCityText')}",
                    labelStyle: TextStyle(
                      fontSize: FontSize.s18,
                      color: primaryColor,
                    ),
                    icon: Icon(Icons.search),
                  ),
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "${lang.translate('screen.register.selectCityText')}",
                    labelText: "${lang.translate('screen.register.selectCityText')}",
                    hintStyle: TextStyle(fontSize: FontSize.s14),
                    labelStyle: TextStyle(fontSize: FontSize.s14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(Sizes.s10)),
                      borderSide: BorderSide(width: 1, color: Colors.grey[100]),
                    ),
                    fillColor: mode.brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.grey[100],
                    filled: !enable,
                  ),
                ),
              ),
              SizedBox(
                height: Sizes.s20,
              ),
              ToggleSwitch(
                minWidth: MediaQuery.of(context).size.width,
                initialLabelIndex: 0,
                cornerRadius: 10.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                labels: ["${lang.translate('screen.register.genderMaleHint')}", "${lang.translate('screen.register.genderFemaleHint')}"],
                icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
                activeBgColors: [Colors.blueAccent, Colors.pinkAccent],
                onToggle: (index) {
                  index == 0 ? _gender = Gender.Male : _gender = Gender.Female ;
                },
              ),
              SizedBox(
                height: Sizes.s40,
              ),
              Container(
                height: Sizes.s40,
                child: GradientButton(
                  title: "${lang.translate('screen.register.registerButton')}",
                  onTap: () async {
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isDismissible: false,
                      builder: (BuildContext context) {
                        return CustomModal.loading(
                          context,
                          "Processing Registration..",
                        );
                      },
                    );
                    await Future.delayed(
                      Duration(milliseconds: 2500),
                      () => Navigator.pop(context),
                    );
                    showToast(_scaffoldKey, "Registration Successfuly");
                  },
                  fontSize: FontSize.s14,
                ),
              ),
              SizedBox(
                height: Sizes.s20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("${lang.translate('screen.register.accountAlt')}"),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => openPage(context, LoginUI()),
                      child: Text(
                        "${lang.translate('screen.register.loginButton')}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

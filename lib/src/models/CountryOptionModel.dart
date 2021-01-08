import 'package:country_pickers/country.dart';
import 'package:hotel_ui_kit/src/blocs/language.bloc.dart';

class CountryOption {
  Country country;
  bool selected;
  String currency;
  String lang;
  Language code;

  CountryOption({
    this.country,
    this.selected,
    this.currency,
    this.lang,
    this.code,
  });
}

import 'package:country_pickers/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ui_kit/src/blocs/language.bloc.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/models/CountryOptionModel.dart';
import 'package:hotel_ui_kit/src/screens/registration/RegisterUI.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/tiles.dart';

class LocalizationUI extends StatefulWidget {
  @override
  _LocalizationUIState createState() => _LocalizationUIState();
}

class _LocalizationUIState extends State<LocalizationUI> {
  List<CountryOption> countries = [
    CountryOption(
      country: countryList.firstWhere((e) => e.isoCode == "FR"),
      selected: false,
      currency: "XAF",
      lang: "French",
      code: Language.FR,
    ),
    CountryOption(
      country: countryList.firstWhere((e) => e.isoCode == "US"),
      selected: false,
      currency: "XAF",
      lang: "English",
      code: Language.EN,
    ),
  ];

  selectCountry(CountryOption country) async {
    BlocProvider.of<LanguageBloc>(context).add(LanguageSelected(country.code));
    openRemovePage(context, RegisterUI());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Choose Language & Currency"),
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: <Widget>[
            SizedBox(height: Sizes.s20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: countries.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    bottom: Sizes.s20,
                    left: Sizes.s20,
                    right: Sizes.s20,
                  ),
                  child: CountryTile(
                    countryOption: countries[index],
                    onTap: () {
                      selectCountry(countries[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

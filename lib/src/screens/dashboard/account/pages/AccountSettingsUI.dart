import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ui_kit/src/blocs/language.bloc.dart';
import 'package:hotel_ui_kit/src/blocs/theme.bloc.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/utils/themes.dart';
import 'package:hotel_ui_kit/src/models/CountryOptionModel.dart';
import 'package:hotel_ui_kit/src/screens/faq/FaqUI.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/tiles.dart';

class AccountSettingsUI extends StatefulWidget {
  @override
  _AccountSettingsUIState createState() => _AccountSettingsUIState();
}

class _AccountSettingsUIState extends State<AccountSettingsUI> {
  // dummy data for countries
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

  // divider
  Widget get divider {
    return SizedBox(
      height: Sizes.s25,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.settings.appBar')}"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView(
          padding: EdgeInsets.all(Sizes.s15),
          children: <Widget>[
            Text(
              "${lang.translate('screen.settings.appBar')}",
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Sizes.s10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "${lang.translate('screen.settings.nightModeLabel')}",
              ),
              trailing: Container(
                height: Sizes.s50,
                width: Sizes.s50,
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return DayNightSwitcher(
                      isDarkModeEnabled:
                          themeState.themeMode == ThemeMode.dark ? true : false,
                      onStateChanged: (state) =>
                          BlocProvider.of<ThemeBloc>(context).add(
                        ThemeChanged(state),
                      ),
                    );
                  },
                ),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "${lang.translate('screen.settings.languageLabel')}",
              ),
              trailing: PopupMenuButton<CountryOption>(
                child: BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, languageState) {
                    var selectedLanguage =
                        languageState?.locale?.countryCode ?? "US";
                    return Container(
                      height: Sizes.s30,
                      width: Sizes.s50,
                      child: Container(
                        child: CountryPickerUtils.getDefaultFlagImage(
                          countryList.firstWhere(
                            (element) => element.isoCode == selectedLanguage,
                          ),
                        ),
                        decoration: BoxDecoration(boxShadow: [customShadow()]),
                      ),
                    );
                  },
                ),
                onSelected: (CountryOption result) {
                  BlocProvider.of<LanguageBloc>(context).add(
                    LanguageSelected(result.code),
                  );
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<CountryOption>>[
                  for (var country in countries)
                    PopupMenuItem<CountryOption>(
                      value: country,
                      child: CountryTile(
                        countryOption: country,
                        onTap: null,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: Sizes.s20),
            Text(
              "${lang.translate('screen.settings.supportTag')}",
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Sizes.s10),
            ListTile(
              onTap: () => openPage(context, FaqUI()),
              contentPadding: EdgeInsets.zero,
              title: Text("${lang.translate('screen.settings.faqTitle')}"),
              subtitle:
                  Text("${lang.translate('screen.settings.faqSubtitle')}"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            Divider(),
            ListTile(
              onTap: () => openWebView(
                context,
                "${lang.translate('screen.settings.feedbackTitle')}",
                "https://www.privacypolicies.com/blog/privacy-policy-template/",
              ),
              contentPadding: EdgeInsets.zero,
              title: Text("${lang.translate('screen.settings.feedbackTitle')}"),
              subtitle:
                  Text("${lang.translate('screen.settings.feedbackSubtitle')}"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            SizedBox(height: Sizes.s20),
            Text(
              "${lang.translate('screen.settings.legalTag')}",
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Sizes.s10),
            ListTile(
              onTap: () => openWebView(
                context,
                "${lang.translate('screen.settings.privacyPolicyTitle')}",
                "https://www.privacypolicies.com/blog/privacy-policy-template/",
              ),
              contentPadding: EdgeInsets.zero,
              title: Text(
                  "${lang.translate('screen.settings.privacyPolicyTitle')}"),
              subtitle: Text(
                  "${lang.translate('screen.settings.privacyPolicySubtitle')}"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            Divider(),
            ListTile(
              onTap: () => openWebView(
                context,
                "${lang.translate('screen.settings.tosTitle')}",
                "https://www.websitepolicies.com/blog/sample-terms-service-template",
              ),
              contentPadding: EdgeInsets.zero,
              title: Text("${lang.translate('screen.settings.tosTitle')}"),
              subtitle:
                  Text("${lang.translate('screen.settings.tosSubtitle')}"),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/models/LocationModel.dart';
import 'package:hotel_ui_kit/src/services/location_service.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'dart:math';

class SearchLocationUI extends StatefulWidget {
  @override
  _SearchLocationUIState createState() => _SearchLocationUIState();
}

class _SearchLocationUIState extends State<SearchLocationUI> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<LocationModel> _locations;
  bool _isSearching = false;
  final rand = Random();

  searchLocation(String keyword) async {
    setState(() {
      _isSearching = true;
    });
    LocationService _service = LocationService();
    await _service.fetchLocations(keyword).then((value) {
      setState(() {
        _isSearching = false;
        _locations = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    searchLocation("Yogyakarta");
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("${lang.translate('screen.searchLoctaion.appBar')}"),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: <Widget>[
            Container(
              height: Sizes.s50,
              width: double.maxFinite,
              child: TextFormField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  hintText:
                      "${lang.translate('screen.searchLoctaion.searchHint')}",
                  contentPadding: EdgeInsets.only(left: Sizes.s15),
                ),
                onEditingComplete: () async {
                  FocusScope.of(context).unfocus();
                  await searchLocation(_searchCtrl.text);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: _isSearching
                  ? Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : _locations != null && _locations?.length != null
                      ? _locations.length < 1
                          ? Center(
                              child: Text(
                                  "${lang.translate('screen.searchLoctaion.locationNotFound')}"),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.only(top: Sizes.s15),
                              itemCount: _locations.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(
                                      context,
                                      _locations[index].placeName,
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: FontSize.s14,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: Sizes.s5,
                                        ),
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              text: '',
                                              style: TextStyle(
                                                fontSize: FontSize.s14,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .color,
                                                height: 1.5,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: _locations[index]
                                                      .placeName,
                                                ),
                                                TextSpan(
                                                  text: " (${rand.nextInt(150)}+ " +
                                                      "${lang.translate('screen.searchLoctaion.hotel')} )",
                                                  style: TextStyle(
                                                    fontSize: FontSize.s12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                      : Center(
                          child: Text(
                            "${lang.translate('screen.searchLoctaion.keywordHint')}",
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}

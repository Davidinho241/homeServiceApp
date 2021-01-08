import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/modal.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/screens/search_location/SearchLocationUI.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/inputs.dart';
import 'package:intl/intl.dart';

class SearchOptionUI extends StatefulWidget {
  final String location;
  SearchOptionUI({this.location});
  @override
  _SearchOptionUIState createState() => _SearchOptionUIState();
}

class _SearchOptionUIState extends State<SearchOptionUI> {
  final dateFormat = DateFormat('dd LLL yyyy');

  TextEditingController _landmarkCtrl = TextEditingController();
  TextEditingController _checkInCtrl =
      TextEditingController(text: "22 Aug 2020");
  TextEditingController _checkOutCtrl =
      TextEditingController(text: "25 Aug 2020");
  TextEditingController _roomGuestCtrl =
      TextEditingController(text: "2 Guest & 2 Room");

  Future<void> _selectDate(
      BuildContext context, TextEditingController ctrl) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2021));
    if (picked != null)
      setState(() {
        ctrl.text = dateFormat.format(picked);
      });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _landmarkCtrl.text = widget?.location ?? 'Search landmark';
    });
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
      ),
      body: Container(
        // padding: EdgeInsets.all(Sizes.s15),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(Sizes.s20),
                height: Sizes.s40,
                width: double.maxFinite,
                child: GradientButton(
                  title:
                      "${lang.translate('screen.searchOption.searchButton')}",
                  onTap: () => Navigator.pop(context),
                  fontSize: FontSize.s18,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(left: Sizes.s15, right: Sizes.s15),
              child: Column(
                children: <Widget>[
                  SearchOptionTextField(
                    controller: _landmarkCtrl,
                    label:
                        "${lang.translate('screen.searchOption.landmarkLabel')}",
                    onTap: () async {
                      final res = await openPage(context, SearchLocationUI());
                      if (res != null) {
                        setState(() {
                          _landmarkCtrl.text = res;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: Sizes.s15,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SearchOptionTextField(
                          controller: _checkInCtrl,
                          label:
                              "${lang.translate('screen.searchOption.checkInLabel')}",
                          onTap: () async {
                            _selectDate(context, _checkInCtrl);
                          },
                        ),
                      ),
                      Container(
                        width: Sizes.s20,
                      ),
                      Expanded(
                        flex: 1,
                        child: SearchOptionTextField(
                          controller: _checkOutCtrl,
                          label:
                              "${lang.translate('screen.searchOption.checkOutLabel')}",
                          onTap: () async {
                            _selectDate(context, _checkOutCtrl);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Sizes.s15,
                  ),
                  SearchOptionTextField(
                    controller: _roomGuestCtrl,
                    label:
                        "${lang.translate('screen.searchOption.roomAndGuestLabel')}",
                    onTap: () async {
                      final result = await showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (builder) {
                            return CustomModal.show(context);
                          });
                      if (result != null) {
                        setState(() {
                          _roomGuestCtrl.text = result[0].data +
                              " ${lang.translate('screen.searchOption.room')}" +
                              "  & " +
                              result[1].data +
                              " ${lang.translate('screen.searchOption.guest')}";
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedData {
  String data;
  bool selected;

  SelectedData({this.data, this.selected});
}

import 'package:flutter/material.dart';
import 'package:home_service/src/models/SelectedDataModel.dart';
import 'package:home_service/src/utils/colors.dart';
import 'package:home_service/src/utils/sizes.dart';
import 'package:home_service/src/widgets/buttons.dart';

import 'localization.dart';

class CustomModal {
  static List<SelectedData> _rooms = [
    SelectedData(data: "1", selected: false),
    SelectedData(data: "2", selected: true),
    SelectedData(data: "3", selected: false),
    SelectedData(data: "4", selected: false),
    SelectedData(data: "5", selected: false),
  ];

  static List<SelectedData> _guest = [
    SelectedData(data: "1", selected: false),
    SelectedData(data: "2", selected: false),
    SelectedData(data: "3", selected: true),
    SelectedData(data: "4", selected: false),
    SelectedData(data: "5", selected: false),
    SelectedData(data: "6", selected: false),
    SelectedData(data: "7", selected: false),
    SelectedData(data: "8", selected: false),
    SelectedData(data: "9", selected: false),
    SelectedData(data: "10", selected: false),
    SelectedData(data: "11", selected: false),
    SelectedData(data: "12", selected: false),
  ];
  static show(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return StatefulBuilder(builder: (context, setState) {
      return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.s15),
          topRight: Radius.circular(Sizes.s15),
        ),
        child: Container(
          height: Sizes.s280,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              top: Sizes.s20,
                              bottom: Sizes.s10,
                            ),
                            child: Text(
                              "${lang.translate('screen.searchOption.totalRoomLabel')}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.s15,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Material(
                                  color: _rooms[index].selected
                                      ? Colors.grey[300]
                                      : Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      _rooms.forEach((element) {
                                        if (element.data ==
                                            _rooms[index].data) {
                                          setState(() {
                                            element.selected = true;
                                          });
                                        } else {
                                          setState(() {
                                            element.selected = false;
                                          });
                                        }
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.maxFinite,
                                      height: Sizes.s40,
                                      child: Text(
                                        "${_rooms[index].data}",
                                        style: TextStyle(
                                          fontSize: FontSize.s15,
                                          fontWeight: FontWeight.bold,
                                          color: _rooms[index].selected
                                              ? primaryColor
                                              : Theme.of(context)
                                                  .textTheme
                                                  .headline3
                                                  .color,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: _rooms.length,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              top: Sizes.s20,
                              bottom: Sizes.s10,
                            ),
                            child: Text(
                              "${lang.translate('screen.searchOption.totalGuestLabel')}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.s15,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Material(
                                  color: _guest[index].selected
                                      ? Colors.grey[300]
                                      : Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      _guest.forEach((element) {
                                        if (element.data ==
                                            _guest[index].data) {
                                          setState(() {
                                            element.selected = true;
                                          });
                                        } else {
                                          setState(() {
                                            element.selected = false;
                                          });
                                        }
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.maxFinite,
                                      height: Sizes.s40,
                                      child: Text(
                                        "${_guest[index].data}",
                                        style: TextStyle(
                                          fontSize: FontSize.s15,
                                          fontWeight: FontWeight.bold,
                                          color: _guest[index].selected
                                              ? primaryColor
                                              : Theme.of(context)
                                                  .textTheme
                                                  .headline3
                                                  .color,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: _guest.length,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Sizes.s60,
                width: double.maxFinite,
                margin: EdgeInsets.fromLTRB(
                  Sizes.s10,
                  Sizes.s10,
                  Sizes.s10,
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: Sizes.s40,
                        child: OutlineButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "${lang.translate('screen.searchOption.cancel')}",
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: Sizes.s15,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: Sizes.s40,
                        child: GradientButton(
                          title:
                              "${lang.translate('screen.searchOption.saveButton')}",
                          onTap: () {
                            // index 0 = rooms
                            // index 1 = guest
                            List<SelectedData> datas = [];
                            datas.add(
                                _rooms.firstWhere((e) => e.selected == true));
                            datas.add(
                                _guest.firstWhere((e) => e.selected == true));
                            Navigator.pop(context, datas);
                          },
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  static loading(BuildContext context, String title) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.s15),
          topRight: Radius.circular(Sizes.s15),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          height: Sizes.s100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("$title"),
                SizedBox(
                  height: Sizes.s10,
                ),
                LinearProgressIndicator(),
                SizedBox(
                  height: Sizes.s15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

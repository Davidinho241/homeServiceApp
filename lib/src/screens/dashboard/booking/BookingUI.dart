import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/models/BookingHistory.dart';
import 'package:hotel_ui_kit/src/services/local_service.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/cards.dart';

class BookingUI extends StatefulWidget {
  @override
  _BookingUIState createState() => _BookingUIState();
}

class _BookingUIState extends State<BookingUI> {
  List<BookingHistory> histories = []; // history data
  bool _loaded = false; // is loaded

  @override
  void initState() {
    super.initState();
    LocalService.loadBookingHistory().then((value) {
      setState(() {
        _loaded = true;
        histories = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: _loaded
          ? ListView.builder(
              padding: EdgeInsets.all(Sizes.s15),
              itemCount: histories.length,
              itemBuilder: (context, index) {
                return BookingHistoryCard(history: histories[index]);
              },
            )
          : Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/models/NotificationModel.dart';
import 'package:hotel_ui_kit/src/services/local_service.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class NotificationUI extends StatefulWidget {
  @override
  _NotificationUIState createState() => _NotificationUIState();
}

class _NotificationUIState extends State<NotificationUI> {
  List<NotificationModel> notifications = []; // notifications list
  bool _loaded = false; // identifier if notifications is loaded or not

  @override
  void initState() {
    super.initState();
    // loading dummy notification
    LocalService.loadNotifications().then((value) async {
      await Future.delayed(Duration(milliseconds: 2000));
      setState(() {
        notifications = value;
        _loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: _loaded
          ? ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                NotificationModel notif = notifications[index];
                return Container(
                  decoration: BoxDecoration(
                    color: notif.seen
                        ? primaryColor.withOpacity(.2)
                        : Colors.transparent,
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.grey.withOpacity(.3),
                      ),
                    ),
                  ),
                  child: Center(
                    child: ListTile(
                      isThreeLine: true,
                      leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "${notif.image}",
                          width: Sizes.s50,
                          height: Sizes.s50,
                        ),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${notif.title}",
                              style: TextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            "${notif.createdAt}",
                            style: TextStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: Sizes.s5),
                        child: Text(
                          "${notif.message}",
                          style: TextStyle(fontSize: FontSize.s10),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }
}

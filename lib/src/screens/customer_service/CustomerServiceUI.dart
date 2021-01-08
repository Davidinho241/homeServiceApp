import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/utils/themes.dart';
import 'package:hotel_ui_kit/src/helpers/toast.dart';
import 'package:hotel_ui_kit/src/models/Message.dart';
import 'package:hotel_ui_kit/src/screens/faq/FaqUI.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class CustomerServiceUI extends StatefulWidget {
  @override
  _CustomerServiceUIState createState() => _CustomerServiceUIState();
}

class _CustomerServiceUIState extends State<CustomerServiceUI> {
  static String myId = "test123"; // message receiver id
  static String senderId = "test321"; // message sender id
  TextEditingController controller =
      TextEditingController(); // message controller
  ScrollController _scrollController = ScrollController(); // scroll controller
  var _scaffoldKey = GlobalKey<ScaffoldState>(); // scaffold identifier

  // dummy data for messages
  List<Message> messages = [
    // dummy data for helpdesk
    Message(
      id: 0,
      idFrom: "",
      idTo: "",
      content: "",
      type: 0,
    ),
    // end
    Message(
      id: 1,
      idFrom: myId,
      idTo: senderId,
      content: "Hello",
      type: 0,
    ),
    Message(
      id: 2,
      idFrom: myId,
      idTo: senderId,
      content: "Lorem ipsum dolor sit amet,",
      type: 0,
    ),
    Message(
      id: 1,
      idFrom: senderId,
      idTo: myId,
      content:
          "consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      type: 0,
    ),
    Message(
      id: 1,
      idFrom: myId,
      idTo: senderId,
      content: "Ut enim ad minim veniam",
      type: 0,
    ),
    Message(
      id: 1,
      idFrom: senderId,
      idTo: myId,
      content: "quis nostrud exercitation ullamco",
      type: 0,
    ),
    Message(
      id: 1,
      idFrom: senderId,
      idTo: myId,
      content: "laboris nisi ut aliquip ex ea commodo consequat.",
      type: 0,
    ),
    Message(
      id: 1,
      idFrom: myId,
      idTo: senderId,
      content: "Duis aute irure dolor in reprehenderit in voluptate",
      type: 0,
    ),
    Message(
      id: 1,
      idFrom: senderId,
      idTo: myId,
      content: "velit esse cillum dolore eu fugiat nulla pariatur.",
      type: 0,
    ),
    Message(
      id: 1,
      idFrom: myId,
      idTo: senderId,
      content: "Excepteur sint occaecat cupidatat non proident",
      type: 0,
    ),
    Message(
      id: 1,
      idFrom: senderId,
      idTo: myId,
      content: "sunt in culpa qui officia deserunt mollit anim id est laborum.",
      type: 0,
    ),
  ];

  // message widget
  Widget buildTextMessage(String content, bool mine) {
    return Container(
      constraints: BoxConstraints(maxWidth: Sizes.s300),
      child: Text(
        "$content",
        style: TextStyle(
          color: mine ? Colors.white : Colors.black.withOpacity(.5),
        ),
      ),
      padding: EdgeInsets.fromLTRB(Sizes.s15, Sizes.s10, Sizes.s15, Sizes.s10),
      decoration: mine
          // if message is sent by me
          ? BoxDecoration(
              color: Color(0xff2483f3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Sizes.s30),
                bottomLeft: Radius.circular(Sizes.s30),
                topRight: Radius.circular(Sizes.s30),
                bottomRight: Radius.circular(0),
              ),
            )
          // if message is sent by other user
          : BoxDecoration(
              color: Color(0xffeceff3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Sizes.s30),
                bottomRight: Radius.circular(Sizes.s30),
                topRight: Radius.circular(Sizes.s30),
                bottomLeft: Radius.circular(0),
              ),
            ),
      margin: EdgeInsets.only(
        bottom: Sizes.s20,
        // if message is sent by me, then set widget stick to right
        right: mine ? Sizes.s10 : 0,
        // if message is sent by other user, then set widget stick to left
        left: mine ? 0 : Sizes.s10,
      ),
    );
  }

  // if message is file (images, doc, etc.)
  Widget buildDocumentMessage(String content, bool mine) {
    var lang = AppLocalizations.of(context);
    return InkWell(
      onTap: () {
        showToast(_scaffoldKey,
            "${lang.translate('screen.customerService.openBtn')} : $content");
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: Sizes.s300),
        decoration: mine
            ? BoxDecoration(
                color: Color(0xff2483f3),
                borderRadius: BorderRadius.all(Radius.circular(Sizes.s30)),
              )
            : BoxDecoration(
                color: Color(0xffeceff3),
                borderRadius: BorderRadius.all(Radius.circular(Sizes.s30)),
              ),
        margin: EdgeInsets.only(
          bottom: Sizes.s20,
          right: mine ? Sizes.s10 : 0,
          left: mine ? 0 : Sizes.s10,
        ),
        padding: EdgeInsets.all(Sizes.s10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.insert_drive_file,
                  color: Colors.white,
                  size: FontSize.s16,
                ),
                SizedBox(width: Sizes.s5),
                Flexible(
                  child: Text(
                    content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: mine ? Colors.white : Colors.black.withOpacity(.5),
                      fontSize: FontSize.s14,
                    ),
                  ),
                )
              ],
            ),
            Text(
              "${lang.translate('screen.customerService.openBtn')}",
              style: TextStyle(
                color: mine ? Colors.white : Colors.black.withOpacity(.5),
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  // message wrapper
  Widget buildItem(Message message) {
    return Row(
      children: <Widget>[
        // if message type is text
        message.type == 0
            ? buildTextMessage(message.content, message.idFrom == myId)
            // if message type is document
            : buildDocumentMessage(message.content, message.idFrom == myId)
      ],
      // if message sent by me, widget alignment set to right (end) else set to left (start)
      mainAxisAlignment: message.idFrom == myId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
    );
  }

  // handling method if user want to upload a file
  void hanldePickFile() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (file != null) {
      messages.add(Message(
        id: 1,
        idTo: senderId,
        idFrom: myId,
        content: file.path.split('/').last,
        type: 1,
      ));
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent + Sizes.s100,
      );
      setState(() {});
    }
  }

  // available customer services
  Widget availableCustomerService() {
    return Row(
      children: <Widget>[
        Container(
          width: Sizes.s30,
          height: Sizes.s30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                "https://img.freepik.com/free-photo/medium-close-up-shot-woman-staring_23-2148248518.jpg?size=626&ext=jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: Sizes.s10),
        Container(
          width: Sizes.s30,
          height: Sizes.s30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: Sizes.s10),
        Container(
          width: Sizes.s30,
          height: Sizes.s30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                "https://cdn.pocket-lint.com/r/s/1200x630/assets/images/142207-phones-feature-what-is-apple-face-id-and-how-does-it-work-image1-5d72kjh6lq.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: Sizes.s10),
        Container(
          width: Sizes.s30,
          height: Sizes.s30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                "https://facegen.com/images/main_face.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: Sizes.s10),
        Container(
          width: Sizes.s30,
          height: Sizes.s30,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.black.withOpacity(.6)),
          child: Center(
            child: Text(
              "8+",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s10,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // helpdesk widget
  Widget helpDesk() {
    var lang = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () => openPage(context, FaqUI()),
          child: Container(
            padding: EdgeInsets.all(Sizes.s10),
            margin: EdgeInsets.only(left: Sizes.s15),
            width: Sizes.s250,
            decoration: BoxDecoration(
              gradient: chatGradient(),
              boxShadow: [customShadow()],
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.s15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${lang.translate('screen.customerService.msgTitle')}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.s14,
                  ),
                ),
                SizedBox(height: Sizes.s10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${lang.translate('screen.customerService.msgSubtitle')}",
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    final ThemeData mode = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.only(left: Sizes.s15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${lang.translate('screen.customerService.title')}",
                style: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Sizes.s5),
              Text(
                "${lang.translate('screen.customerService.subtitle')}",
                style: TextStyle(
                  fontSize: FontSize.s12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
        bottom: PreferredSize(
          child: Container(
            margin: EdgeInsets.only(left: Sizes.s15),
            height: Sizes.s50,
            width: double.maxFinite,
            color: Theme.of(context).appBarTheme.color,
            child: availableCustomerService(),
          ),
          preferredSize: Size.fromHeight(50),
        ),
      ),
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: Sizes.s15),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    // if first index then show helpdesk widget
                    return index == 0 ? helpDesk() : buildItem(messages[index]);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(.2),
                      offset: Offset(2, 0),
                      blurRadius: 8,
                      spreadRadius: 5,
                    )
                  ],
                  color: mode.brightness == Brightness.dark
                      ? Colors.grey[900]
                      : Colors.grey[100],
                ),
                height: Sizes.s60,
                width: double.maxFinite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FlutterIcons.plus_circle_outline_mco),
                      onPressed: hanldePickFile,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              "${lang.translate('screen.customerService.writeMsg')}",
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(FlutterIcons.send_mco),
                        onPressed: () {
                          // if message text is empty
                          controller.text.length < 1
                              ? showToast(_scaffoldKey,
                                  "${lang.translate('screen.customerService.emptyMsg')}")
                              : messages.add(Message(
                                  id: 1,
                                  idTo: senderId,
                                  idFrom: myId,
                                  content: controller.text,
                                  type: 0,
                                ));
                          controller.clear();
                          _scrollController.jumpTo(
                            _scrollController.position.maxScrollExtent +
                                Sizes.s100,
                          );
                          setState(() {});
                        }),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

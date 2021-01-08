import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/models/FaqModel.dart';
import 'package:hotel_ui_kit/src/services/local_service.dart';
import 'package:hotel_ui_kit/src/utils/colors.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class FaqUI extends StatefulWidget {
  @override
  _FaqUIState createState() => _FaqUIState();
}

class _FaqUIState extends State<FaqUI> {
  bool _isLoaded = false;
  List<FaqModel> faqs;

  @override
  void initState() {
    super.initState();
    LocalService.loadFaqs().then((value) {
      setState(() {
        faqs = value;
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      appBar: AppBar(
        title: Text("Frequently Asked Questions"),
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: _isLoaded
            ? ListView.builder(
                padding: EdgeInsets.all(Sizes.s15),
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  FaqModel faq = faqs[index];
                  return Theme(
                    data: theme,
                    child: ListTileTheme(
                      selectedColor: primaryColor,
                      contentPadding: EdgeInsets.only(bottom: Sizes.s15),
                      child: ExpansionTile(
                        backgroundColor: Colors.transparent,
                        initiallyExpanded: false,
                        title: Text(
                          "${faq.title}",
                          style: TextStyle(
                            fontSize: FontSize.s16,
                          ),
                        ),
                        children: [
                          Text("${faq.content}"),
                          SizedBox(
                            height: Sizes.s20,
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CupertinoActivityIndicator(),
              ),
      ),
    );
  }
}

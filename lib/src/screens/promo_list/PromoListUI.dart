import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/models/PromoModel.dart';
import 'package:hotel_ui_kit/src/screens/promo_detail/PromoDetailUI.dart';
import 'package:hotel_ui_kit/src/services/local_service.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class PromoListUI extends StatefulWidget {
  @override
  _PromoListUIState createState() => _PromoListUIState();
}

class _PromoListUIState extends State<PromoListUI> {
  List<PromoModel> _deals = [];
  bool _dealsLoaded = false;

  initializeDeals() async {
    await LocalService.loadDeals().then((value) {
      setState(() {
        _deals = value;
        _dealsLoaded = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hot Deals"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(Sizes.s15),
        child: _dealsLoaded
            ? ListView.builder(
                itemCount: _deals.length,
                itemBuilder: (context, index) {
                  PromoModel deal = _deals[index];
                  return InkWell(
                    onTap: () => openPage(context, PromoDetailUI(promo: deal)),
                    child: Container(
                      margin: EdgeInsets.only(bottom: Sizes.s20),
                      height: Sizes.s200,
                      width: double.maxFinite,
                      child: Stack(
                        children: <Widget>[
                          FadeInImage.assetNetwork(
                            placeholder: "assets/images/misc/placeholder.png",
                            image: deal.thumbnail,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(Sizes.s5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                              ),
                              height: Sizes.s40,
                              width: double.maxFinite,
                              child: Text(
                                "${deal.title}",
                                maxLines: 1,
                              ),
                            ),
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

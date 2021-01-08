import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/currency.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/helpers/navigation.dart';
import 'package:hotel_ui_kit/src/utils/themes.dart';
import 'package:hotel_ui_kit/src/models/BlogModel.dart';
import 'package:hotel_ui_kit/src/models/HotelModel.dart';
import 'package:hotel_ui_kit/src/models/PlaceModel.dart';
import 'package:hotel_ui_kit/src/models/PromoModel.dart';
import 'package:hotel_ui_kit/src/screens/blog_detail/BlogDetailUI.dart';
import 'package:hotel_ui_kit/src/screens/detail/DetailUI.dart';
import 'package:hotel_ui_kit/src/screens/list/HotelListUI.dart';
import 'package:hotel_ui_kit/src/screens/list/HotelListV2UI.dart';
import 'package:hotel_ui_kit/src/screens/promo_detail/PromoDetailUI.dart';
import 'package:hotel_ui_kit/src/screens/promo_list/PromoListUI.dart';
import 'package:hotel_ui_kit/src/services/local_service.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';
import 'package:hotel_ui_kit/src/widgets/cards.dart';
import 'package:hotel_ui_kit/src/widgets/common_widgets.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  bool _popularLoaded = false; // is popular loaded
  List<Hotel> _popularHotels = []; // popular hotels data
  bool _placesLoaded = false; // is places loaded
  List<Place> _places = []; // places data
  bool _blogsLoaded = false; // is blog loaded
  List<Blog> _blogs = []; // blogs data
  bool _dealsLoaded = false; // deals is loaded
  List<PromoModel> _deals = []; // deals data

  // initializing data
  initializeData() async {
    // loading hot deals
    await LocalService.loadDeals().then((value) {
      setState(() {
        _deals = value;
        _dealsLoaded = true;
      });
    });

    // loading hotels
    await LocalService.loadHotels(true).then((value) {
      setState(() {
        _popularHotels = value;
        _popularLoaded = true;
      });
    });

    // loading places
    await LocalService.loadPlaces().then((value) {
      setState(() {
        _places = value;
        _placesLoaded = true;
      });
    });

    // loading blogs
    await LocalService.loadBlogs().then((value) {
      setState(() {
        _blogs = value;
        _blogsLoaded = true;
      });
    });
  }

  Widget nearbyCard() {
    var lang = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: Sizes.s20, right: Sizes.s10),
      child: Column(
        children: <Widget>[
          Container(
            height: Sizes.s50,
            width: Sizes.s50,
            decoration: BoxDecoration(
              gradient: customGradient(),
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.s10),
              ),
            ),
            child: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Sizes.s5),
          Text(
            "${lang.translate('screen.home.nearMe')}",
            style: TextStyle(
              fontSize: FontSize.s12,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    // init localization
    var lang = AppLocalizations.of(context);
    // init currency
    String currency = userCurrency(context);
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: Sizes.s15,
            ),
            // Container(
            //   margin: EdgeInsets.only(left: Sizes.s20, right: Sizes.s20),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: "${lang.translate('screen.home.searchHint')}",
            //       prefixIcon: Icon(Icons.search),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(30.0),
            //         ),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.grey[300], width: 1),
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(Sizes.s30),
            //         ),
            //       ),
            //       contentPadding: EdgeInsets.symmetric(vertical: Sizes.s10),
            //     ),
            //   ),
            // ),
            // SizedBox(height: Sizes.s20),
            Container(
              height: Sizes.s80,
              child: _placesLoaded
                  ? ListView.builder(
                      itemCount: _places.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => openPage(
                            context,
                            HotelListUI(
                              location: _places[index].name,
                            ),
                          ),
                          // if first index, show nearby location
                          child: index == 0
                              ? nearbyCard()
                              : PlaceCards(
                                  image: "${_places[index].image}",
                                  placeName: "${_places[index].name}",
                                ),
                        );
                      },
                    )
                  : Container(
                      margin: EdgeInsets.only(left: Sizes.s15),
                      child: ListView.builder(
                        itemCount: 8,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // place loader
                          return PlaceCardLoader();
                        },
                      ),
                    ),
            ),
            SizedBox(height: Sizes.s10),
            TitleWrapper(
              title: "${lang.translate('screen.home.popularTag')}",
              onTap: () => openPage(context, HotelListV2UI()),
            ),
            SizedBox(
              height: Sizes.s15,
            ),
            Container(
              height: Sizes.s270,
              child: _popularLoaded
                  ? ListView.builder(
                      itemCount: _popularHotels.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            right: index == 4 ? Sizes.s20 : 0,
                          ),
                          child: PopularCards(
                            onTap: () => openPage(
                              context,
                              DetailUI(hotel: _popularHotels[index]),
                            ),
                            hotel: _popularHotels[index],
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return PopularCardLoader();
                      },
                    ),
            ),
            SizedBox(
              height: Sizes.s20,
            ),
            TitleWrapper(
              title: "${lang.translate('screen.home.bestTag')}",
              onTap: () => openPage(context, HotelListUI(location: null)),
            ),
            SizedBox(
              height: Sizes.s15,
            ),
            _popularLoaded
                ? ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _popularHotels.length,
                    itemBuilder: (context, index) {
                      return BestOfferCards(
                        onTap: () => openPage(
                          context,
                          DetailUI(hotel: _popularHotels[index]),
                        ),
                        hotel: _popularHotels[index],
                      );
                    },
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return BestOfferCardLoader();
                    },
                  ),
            SizedBox(height: 10),
            TitleWrapper(
              title: "${lang.translate('screen.home.promoTag')}",
              onTap: () => openPage(context, PromoListUI()),
            ),
            SizedBox(
              height: Sizes.s15,
            ),
            Container(
              child: _dealsLoaded
                  ? CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        initialPage: 2,
                        autoPlay: false,
                      ),
                      items: _deals
                          .map(
                            (item) => InkWell(
                              onTap: () =>
                                  openPage(context, PromoDetailUI(promo: item)),
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.s15)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        "assets/images/misc/placeholder.png",
                                    image: item.thumbnail,
                                    width: Sizes.s700,
                                    height: Sizes.s200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Center(
                      child: CupertinoActivityIndicator(),
                    ),
            ),
            SizedBox(
              height: Sizes.s30,
            ),
            TitleWrapper(
              title: "${lang.translate('screen.home.nearbyTag')}",
              onTap: () => openPage(context, HotelListV2UI()),
              showButton: true,
            ),
            SizedBox(
              height: Sizes.s15,
            ),
            // card
            _popularLoaded
                ? ListView.builder(
                    padding: EdgeInsets.only(left: Sizes.s20, right: Sizes.s20),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _popularHotels.length,
                    itemBuilder: (context, index) {
                      return NearbyCards(
                        onTap: () => openPage(
                          context,
                          DetailUI(hotel: _popularHotels[index]),
                        ),
                        hotel: _popularHotels[index],
                      );
                    },
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(left: Sizes.s20, right: Sizes.s20),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return NearbyCardLoader();
                    },
                  ),
            SizedBox(
              height: Sizes.s20,
            ),
            TitleWrapper(
              title: "${lang.translate('screen.home.inviteTag')}",
              onTap: null,
              showButton: false,
            ),
            SizedBox(
              height: Sizes.s15,
            ),
            InvitationCards(),
            SizedBox(
              height: Sizes.s25,
            ),
            TitleWrapper(
              title: "${lang.translate('screen.home.travelTag')}",
              onTap: null,
              showButton: false,
            ),
            SizedBox(
              height: Sizes.s15,
            ),
            Container(
              height: Sizes.s190,
              child: _blogsLoaded
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _blogs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            left: Sizes.s20,
                            right: index == 4 ? Sizes.s20 : 0,
                          ),
                          child: BlogCards(
                            blog: _blogs[index],
                            onTap: () => openPage(
                                context, BlogDetailUI(blog: _blogs[index])),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            left: Sizes.s20,
                            right: index == 4 ? Sizes.s20 : 0,
                          ),
                          child: BlogCardLoader(),
                        );
                      },
                    ),
            ),
            SizedBox(
              height: Sizes.s15,
            ),
            TitleWrapper(
              title: "${lang.translate('screen.home.findTag')}",
              onTap: null,
              showButton: false,
            ),
            SizedBox(
              height: Sizes.s15,
            ),
            Container(
              height: Sizes.s30,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: Sizes.s20),
                    child: GradientButton(
                      title:
                          "${lang.translate('screen.home.lessThan')} ${currency}10",
                      onTap: () => openPage(context, HotelListV2UI()),
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Sizes.s10),
                    child: GradientButton(
                      title: "${currency}10 - ${currency}30",
                      onTap: () => openPage(context, HotelListV2UI()),
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Sizes.s10),
                    child: GradientButton(
                      title: "${currency}30 - ${currency}70",
                      onTap: () => openPage(context, HotelListV2UI()),
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Sizes.s10),
                    child: GradientButton(
                      title: "${currency}70 - ${currency}100",
                      onTap: () => openPage(context, HotelListV2UI()),
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Sizes.s10, right: Sizes.s20),
                    child: GradientButton(
                      title:
                          "${lang.translate('screen.home.moreThan')} ${currency}100",
                      onTap: () => openPage(context, HotelListV2UI()),
                      fontSize: FontSize.s14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Sizes.s20,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/helpers/localization.dart';
import 'package:hotel_ui_kit/src/models/BlogModel.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';

class BlogDetailUI extends StatefulWidget {
  /// blog detail (received from previous page)
  final Blog blog;
  BlogDetailUI({@required this.blog});

  @override
  _BlogDetailUIState createState() => _BlogDetailUIState();
}

class _BlogDetailUIState extends State<BlogDetailUI> {
  Widget _blogContent() {
    var lang = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.all(Sizes.s15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: Sizes.s10,
          ),
          Text(
            "${lang.translate('screen.blogDetail.postedAt')} : ${widget.blog.date}",
            style: TextStyle(
              fontSize: FontSize.s12,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: Sizes.s10,
          ),
          Text(
            "${widget.blog.title}",
            style: TextStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: Sizes.s10,
          ),
          Text(
            "${widget.blog.content}",
            style: TextStyle(fontSize: FontSize.s15),
          ),
          SizedBox(
            height: Sizes.s10,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${lang.translate('screen.blogDetail.appBar')}"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: "assets/images/misc/placeholder.png",
                image: "${widget.blog.thumbnail}",
                fit: BoxFit.cover,
                height: Sizes.s200,
                width: double.maxFinite,
              ),
              _blogContent()
            ],
          ),
        ),
      ),
    );
  }
}

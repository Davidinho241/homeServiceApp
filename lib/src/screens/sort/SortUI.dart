import 'package:flutter/material.dart';
import 'package:hotel_ui_kit/src/utils/sizes.dart';
import 'package:hotel_ui_kit/src/widgets/buttons.dart';

class SortUI extends StatefulWidget {
  @override
  _SortUIState createState() => _SortUIState();
}

class _SortUIState extends State<SortUI> {
  List<String> _sorts = [
    "Price Low to High",
    "Price High to Low",
    "Distance Low to High",
    "Distance High to Low",
    "Ratings Low to High",
    "Ratings High to Low",
  ];
  int _selectedSort = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sort Result"),
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                padding: EdgeInsets.only(left: Sizes.s20, right: Sizes.s20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _sorts.length,
                itemBuilder: (context, index) {
                  return Material(
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        setState(() {
                          _selectedSort = index;
                        });
                      },
                      title: Text("${_sorts[index]}"),
                      trailing: Radio(
                        value: index,
                        groupValue: _selectedSort,
                        onChanged: (int val) {
                          setState(() {
                            _selectedSort = val;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Sizes.s20, right: Sizes.s20, bottom: Sizes.s20),
              height: Sizes.s40,
              child: GradientButton(
                title: "Save",
                onTap: () => Navigator.pop(context),
                fontSize: FontSize.s15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

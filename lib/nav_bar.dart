import 'package:flutter/widgets.dart';
import 'package:navigation_bar/custom_listview.dart';

class NavBar extends StatefulWidget {
  IndexedWidgetBuilder builder;
  int pageSize;
  int childCount;
  ScrollController scrollController = new ScrollController();

  NavBar(this.builder, this.childCount, {Key key, this.pageSize = 4, this.scrollController})
      : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  static const double HEADER_EXTENT = 16;
  double _itemWidth;
  ScrollController scrollController;

  NavBarState();

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    scrollController = widget.scrollController;
    int itemSize = widget.childCount;
    if(itemSize <=1){
      return Container(height: 0,);
    } else if (itemSize <= widget.pageSize) {
      _itemWidth = (windowWidth - HEADER_EXTENT * 2) / itemSize;
    } else {
      _itemWidth = (windowWidth - HEADER_EXTENT * 2) / widget.pageSize;
    }

    return CustomListView(
      widget.builder,
      scrollDirection: Axis.horizontal,
      scrollController:scrollController,
      header: Container(
        width: HEADER_EXTENT,
      ),
      footer: Container(
        width: HEADER_EXTENT,
      ),
      childCount: widget.childCount,
      itemExtent: _itemWidth,
    );
  }
}

Widget getNarBarItem(
    int index, bool selected, String title, Function(int index) onItemTap) {
  return GestureDetector(
    onTap: () {
      onItemTap(index);
    },
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(2.0),
        color: Color(selected ? 0xffFF00FF0 : 0xffEBF2FF),
      ),
      child: Text(
        title,
        maxLines: 1,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 13,
            color: Color(selected ? 0xff407AFF : 0xff363C48),
            decoration: TextDecoration.none),
      ),
    ),
  );
}

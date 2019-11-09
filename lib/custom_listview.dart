import 'package:flutter/widgets.dart';

/// 外层包装时需要设置宽度或者高度，取决于滑动方向，否则无法显示
class CustomListView extends StatefulWidget {
  Axis scrollDirection;
  ScrollController scrollController;
  Widget header;
  Widget footer;
  IndexedWidgetBuilder builder;
  int childCount;
  double itemExtent;

  CustomListView(this.builder,
      {this.scrollDirection,
        this.scrollController,
        this.header,
        this.footer,
        this.childCount,
        this.itemExtent,
        Key key})
      : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  _CustomListViewState();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: CustomScrollView(
        scrollDirection: widget.scrollDirection,
        controller: widget.scrollController,
        slivers: <Widget>[
          // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
          SliverToBoxAdapter(
            child: widget.header,
          ),
          getList(),
          SliverToBoxAdapter(
            child: widget.footer,
          ),
        ],
      ),
    );
  }

  Widget getList() {
    return widget.itemExtent != null || widget.itemExtent == 0
        ? SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(widget.builder,
            childCount: widget.childCount),
        itemExtent: widget.itemExtent)
        : SliverList(
      delegate: SliverChildBuilderDelegate(widget.builder,
          childCount: widget.childCount),
    );
  }
}


///去掉滑动布局的蓝色回弹效果
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
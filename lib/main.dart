import 'package:flutter/material.dart';
import 'package:navigation_bar/nav_bar.dart';


void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isScrollable = false;
  List<String> itemList = [
    '手机',
    '电脑',
    '书本',
    '爱情',
    '小狗',
    '阿猫',
    '道路',
    '小狗',
    '房子',
    '路由'
  ];

  int _currentIndex = 0;
  String showText = '手机';
  int pageSize = 4;
  double windowWidth;
  double itemWidth;
  ScrollController _controller = new ScrollController();

  double offset = 0;
  double _x;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      offset = _controller.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavBar',
      home: Scaffold(
        appBar: AppBar(
          title: Text('NavBar'),
        ),
        body: getContentWidget(),
      ),
    );
  }

  Widget getContentWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 25,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 8),
            child: Listener(
              onPointerDown: (e) {
                _x = e.position.dx;
              },
              child: NavBar(
                buildNavItem,
                itemList.length,
                pageSize: pageSize,
                scrollController: _controller,
              ),
            ),
          ),
          Container(
            child: Text(
              showText,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(BuildContext context, int index) {
    windowWidth = MediaQuery.of(context).size.width;
    //每一个item长度，包括空隙
    itemWidth = (windowWidth - 16 * 2) / 4;
    String item = itemList[index];
    return getNarBarItem(index, _currentIndex == index, item, (int index) {
      _currentIndex = index;
      showText = item;

      //点击第一个第二个不移动
      if (_x < windowWidth / 2 && offset == 0) {
      } else if (offset > 0 && (index == 1 || index == 0)) {
        //当点击第一个第二个恢复原位
        _controller.jumpTo(-1);
      } else if (_x > windowWidth / 2 && (index == itemList.length-1 || index == itemList.length-2)) {
        _controller.jumpTo((itemList.length - 4) * itemWidth); //最后两个移动到合适位置
      } else {
        //相对于中心轴移动位置
        _controller.jumpTo(
            16 + (index + 0.5) * (windowWidth - 16 * 2) / 4 - windowWidth / 2);
      }

      setState(() {});
    });
  }

  void onPointerDown(e) {
    _x = e.position.dx;
  }
}

import 'package:flutter/material.dart';
import 'package:standardappstructure/ui/page_listing.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => new _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  int _page = 0;
  Widget _list;
  String toolbarTitle="Users";

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_list == null) {
      _list = new ListPage();
    }
    return new Scaffold(
        appBar: new AppBar(title: new Text(toolbarTitle)),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Users")),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted), title: Text("Posts")),
            BottomNavigationBarItem(
                icon: Icon(Icons.photo_library), title: Text("Photos")),
          ],
          currentIndex: _page,
          onTap: navigationTapped,
        ),
        body: new PageView(
            onPageChanged: onPageChanged,
            controller: _pageController,
            children: <Widget>[
              _list,
              _list,
              _list
            ]));
  }

  void navigationTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int value) {
    setState(() {
      this._page = value;

      switch(_page){
        case 0:
          toolbarTitle= "Users";
          break;
        case 1:
          toolbarTitle= "Photos";
          break;
        case 2:
          toolbarTitle= "Posts";
          break;
      }
    });
  }
}

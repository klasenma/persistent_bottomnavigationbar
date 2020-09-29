import 'package:flutter/material.dart';
import 'package:persistent_bottomnavigationbar/screens/main/profile/profile_screen.dart';
import 'package:persistent_bottomnavigationbar/screens/main/search/search_screen.dart';
import '../../enums.dart';
import 'home/home_screen.dart';

/// From https://www.youtube.com/watch?v=qj7jcuU2Z10&t=294s
/// and https://medium.com/coding-with-flutter/flutter-case-study-multiple-navigators-with-bottomnavigationbar-90eb6caa6dbf

class Index extends StatefulWidget {
  static const String id = '/index';

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;
  TabItem _currentPage = TabItem.home;
  List<TabItem> _pageKeys = [TabItem.home, TabItem.search, TabItem.profile];

  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = tabItem;
        _currentIndex = index;
      });
    }
  }

  _buildOffStageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();

        // Before closing the app we want to navigate back to home
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != TabItem.home) {
            _selectTab(TabItem.home, 0);
            return false;
          }
        }

        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildOffStageNavigator(TabItem.home),
            _buildOffStageNavigator(TabItem.search),
            _buildOffStageNavigator(TabItem.profile),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
          )),
          child: BottomNavigationBar(
            onTap: (int index) => _selectTab(_pageKeys[index], index),
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.transparent,
            iconSize: 26,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.home),
                ),
                title: Text(
                  'Home',
                  style: buildTextStyle(TabItem.home),
                ),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.search),
                ),
                title: Text(
                  'Search',
                  style: buildTextStyle(TabItem.search),
                ),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.person),
                ),
                title: Text(
                  'Profile',
                  style: buildTextStyle(TabItem.profile),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle buildTextStyle(TabItem tabItem) {
    return TextStyle(
      fontWeight: _currentPage == tabItem ? FontWeight.bold : FontWeight.normal,
    );
  }
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  const TabNavigator({Key key, this.navigatorKey, this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (tabItem) {
      case TabItem.home:
        child = HomeScreen();
        break;
      case TabItem.search:
        child = SearchScreen();
        break;
      case TabItem.profile:
        child = ProfileScreen();
        break;
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

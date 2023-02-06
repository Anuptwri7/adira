import 'package:flutter/material.dart';

import '../TabPages/HomeTabPage.dart';
import '../TabPages/ProfileTabPage.dart';
import '../TabPages/StockAnalysisTabPage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeTabPage(),
          StockAnaysisTabPage(),
          ProfileTabPage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        iconList: const [
          Icons.home,
          Icons.align_vertical_bottom_rounded,
          Icons.person,
        ],
        onChange: (index) {
          setState(() {
            selectedIndex = index;
            tabController.index = selectedIndex;
          });
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;

  final Function(int) onChange;
  final List<IconData> iconList;

  const CustomBottomNavigationBar(
      {this.defaultSelectedIndex = 0, this.iconList, this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          widget.onChange(index);
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 0, bottom: 10),
          child: Container(
            height: 50,
            width: 60,
            decoration: index == _selectedIndex
                ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(4, 4),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            )
                : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100,
                  offset: const Offset(5, 8),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: index == _selectedIndex
                  ? const Color(0xff2c51a4)
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

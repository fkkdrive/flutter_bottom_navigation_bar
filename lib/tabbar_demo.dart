import 'package:flutter/material.dart';

class TabDemo extends StatefulWidget {
  const TabDemo({super.key});

  @override
  State<TabDemo> createState() => _TabDemoState();
}

class _TabDemoState extends State<TabDemo> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          print(_tabController.index.toString());
          _selectedTab = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tab Demo"),
      ),
      backgroundColor: Colors.white,
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.grey.shade300,
                child: TabBar(
                  unselectedLabelColor: Colors.blue,
                  labelColor: Colors.blue,
                  indicatorColor: Colors.white,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(0.0),
                  tabs: [
                    _getTab(0, const Icon(Icons.directions_car)),
                    _getTab(1, const Icon(Icons.directions_transit)),
                    _getTab(2, const Icon(Icons.directions_bike)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _tabController,
                  children: const [
                    Icon(
                      Icons.directions_car,
                      color: Colors.black,
                      size: 300.0,
                    ),
                    Icon(
                      Icons.directions_transit,
                      color: Colors.black,
                      size: 300.0,
                    ),
                    Icon(
                      Icons.directions_bike,
                      color: Colors.black,
                      size: 300.0,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: child,
          decoration: BoxDecoration(
              color:
                  (_selectedTab == index ? Colors.white : Colors.grey.shade300),
              borderRadius: _generateBorderRadius(index)),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab) {
      return const BorderRadius.only(bottomRight: Radius.circular(10.0));
    } else if ((index - 1) == _selectedTab) {
      return const BorderRadius.only(bottomLeft: Radius.circular(10.0));
    } else {
      return BorderRadius.zero;
    }
  }
}

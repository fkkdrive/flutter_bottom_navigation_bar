import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HideOnScroll extends StatefulWidget {
  const HideOnScroll({super.key});

  @override
  HideOnScrollState createState() => HideOnScrollState();
}

class HideOnScrollState extends State<HideOnScroll>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController animationController;
  late List<Widget> _pages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _pages = <Widget>[
      CallsPage(
        isHideBottomNavBar: (isHideBottomNavBar) {
          isHideBottomNavBar
              ? animationController.forward()
              : animationController.reverse();
        },
      ),
      const Center(
        child: Icon(
          Icons.camera,
          size: 150,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
              labelText: 'Find contact',
              labelStyle: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    // ...
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('With TabBar Demo'),
        elevation: 0,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: SizeTransition(
        sizeFactor: animationController,
        axisAlignment: -1.0,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class CallsPage extends StatelessWidget {
  const CallsPage({super.key, required this.isHideBottomNavBar});
  final Function(bool) isHideBottomNavBar;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Incoming',
                  ),
                  Tab(
                    text: 'Outgoing',
                  ),
                  Tab(
                    text: 'Missed',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const IncomingPage(),
            OutgoingPage(
              isHideBottomNavBar: (value) {
                isHideBottomNavBar(value);
              },
            ),
            const Icon(Icons.call_missed_outgoing, size: 350),
          ],
        ),
      ),
    );
  }
}

class IncomingPage extends StatefulWidget {
  const IncomingPage({super.key});

  @override
  IncomingPageState createState() => IncomingPageState();
}

class IncomingPageState extends State<IncomingPage>
    with AutomaticKeepAliveClientMixin<IncomingPage> {
  int count = 10;

  void clear() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.call_received, size: 350),
              Text('Total incoming calls: $count',
                  style: const TextStyle(fontSize: 30)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: clear,
          child: const Icon(Icons.clear_all),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class OutgoingPage extends StatefulWidget {
  final Function(bool) isHideBottomNavBar;

  const OutgoingPage({super.key, required this.isHideBottomNavBar});

  @override
  OutgoingPageState createState() => OutgoingPageState();
}

class OutgoingPageState extends State<OutgoingPage>
    with AutomaticKeepAliveClientMixin<OutgoingPage> {
  final items = List<String>.generate(10000, (i) => "Call $i");

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            widget.isHideBottomNavBar(true);
            break;
          case ScrollDirection.reverse:
            widget.isHideBottomNavBar(false);
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

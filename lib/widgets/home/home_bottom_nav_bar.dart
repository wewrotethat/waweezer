import 'package:flutter/material.dart';
import 'package:waweezer_mobile/resources/constants.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    Key key,
    @required TabController controller,
  })  : _controller = controller,
        super(key: key);

  final TabController _controller;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 8,
      shape: CircularNotchedRectangle(),
      child: TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.music_note),
          ),
          Tab(
            icon: Icon(Icons.queue_music),
          ),
          Tab(
            icon: Icon(Icons.favorite),
          ),
          Tab(
            icon: Icon(Icons.person),
          )
        ],
        controller: _controller,
        labelStyle: TextStyle(fontSize: 10),
        labelColor: primaryColor,
        unselectedLabelColor: Colors.grey,
        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 45.0),
          borderSide: BorderSide(color: primaryColor, width: 3),
        ),
      ),
    );
  }
}

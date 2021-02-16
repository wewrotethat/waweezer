import 'package:flutter/material.dart';
import 'package:waweezer_mobile/widgets/home/home_bottom_nav_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return;
          }
        },
      ),
      bottomNavigationBar: HomeBottomNavBar(controller: null),
    );
  }
}

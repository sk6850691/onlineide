import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:travel_admin/screens/ProfileDetails.dart';
import 'package:travel_admin/screens/createbikelisting.dart';
import 'package:travel_admin/screens/mylistings.dart';

import 'Bookings.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int _currentIndex = 0;
  onTap(index){
    setState(() {
      pageController.animateToPage(index,duration: Duration(microseconds: 12),curve: Curves.bounceOut);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          onTap(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('page1')),
          BottomNavigationBarItem(icon: Icon(Icons.access_time_outlined),title: Text('page2')),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_sharp),title: Text('page2'))
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          MyListings(),
          Bookings(),
          ProfileDetails()



        ],
        onPageChanged: (index){
          setState(() {

            _currentIndex =index;
          });

        },
      ),


    );
  }
}

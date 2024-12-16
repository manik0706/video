import 'package:flutter/material.dart';
import 'package:sourcecad_app/h/HomeScreens/acc.dart';
import 'package:sourcecad_app/h/HomeScreens/coursedetailscreen.dart';
import 'package:sourcecad_app/h/HomeScreens/courselistscreen.dart';
import 'package:sourcecad_app/h/HomeScreens/download_screen.dart';
import 'package:sourcecad_app/h/HomeScreens/explore_topic.dart';
import 'package:sourcecad_app/widgets/vid_wid.dart';
import 'package:sourcecad_app/widgets/video_player.dart';

import 'account.dart';
import 'featured.dart';
import 'learning.dart';
import 'search.dart';
import 'wishlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  int currentPage = 0;

  void selected(int selection) {
    setState(() {
      currentPage = selection;
    });
    pageController.jumpToPage(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: PageView(
            onPageChanged: (selection) {
              setState(() {
                currentPage = selection;
              });
            },
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeaturedScreen(),
              SearchScreen(),
              // DownloadedVideosScreen(),
              // ExploreTopicssScreen(),
              // CourseListScreen(
              //   courseId: 1,courseName: ,
              // ),
              LearningScreen(),
              // WebViewExample(),
              // CourseScreen(),
              // WishlistScreen(),
              Accounts()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selected,
        backgroundColor: Colors.white,
        selectedIconTheme:
            const IconThemeData(color: Colors.black, opacity: 1, size: 24),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        unselectedIconTheme:
            const IconThemeData(color: Colors.black, opacity: 0.35, size: 24),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.star),
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.star_border),
              ),
              label: "Courses"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.search),
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.play_circle),
              ),
              label: "My Learning"),
          // BottomNavigationBarItem(
          //     activeIcon: Padding(
          //       padding: EdgeInsets.only(bottom: 4.0),
          //       child: Icon(Icons.favorite),
          //     ),
          //     icon: Padding(
          //       padding: EdgeInsets.only(bottom: 4.0),
          //       child: Icon(Icons.favorite_border),
          //     ),
          //     label: "WishList"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.person_pin),
              ),
              label: "Account"),
        ],
      ),
    );
  }
}

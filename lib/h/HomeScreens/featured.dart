import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sourcecad_app/h/HomeScreens/course_detail_screen_pic.dart';
import 'package:sourcecad_app/h/HomeScreens/courselist.dart';
import 'package:sourcecad_app/h/HomeScreens/courselistscreen.dart';
import 'package:sourcecad_app/h/HomeScreens/explore_topic.dart';
import 'package:sourcecad_app/h/controllers/course_pic_controller.dart';
import 'package:sourcecad_app/widgets/course_item_pic.dart';
import 'package:sourcecad_app/widgets/video_player.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  final CoursesPicController coursesController =
      Get.put(CoursesPicController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop(); // Exits the app and takes user to home screen
          return false; // Prevents the default back behavior
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "SourceCAD",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
            ),
            // actions: [
            //   IconButton(
            //       onPressed: () {},
            //       icon: const Icon(
            //         Icons.shopping_cart,
            //         color: Colors.grey,
            //       ))
            // ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 220,
                    width: 500,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/png/header.png'),
                            fit: BoxFit.fill)),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(
                      'Master CAD Skills',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                        'Master CAD tools with hands-on courses and live expert support.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 10),
                    child: Container(
                      color: Colors.yellow.shade200,
                      width: 400,
                      height: 35,
                      child: const Center(
                        child: Text('Future-ready skills on your schedule'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: Text(
                      'Explore Topics',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomCourseRow(),
                  // CustomCourseRow(
                  //   imageUrls: [
                  //     'assets/png/Fusion-360-logo-copy.png',
                  //     'assets/png/Revit.png',
                  //     'assets/png/AutoCAD-architecture.png',
                  //   ],
                  //   courseData: ['Fusion 360', 'Revit', 'AutoCAD'],
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 116, 87, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: Text(
                      'Free Courses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 290,
                    child: const CourseList(
                      isLargeTiled: true,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 20),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(text: 'Top courses in '),
                          TextSpan(
                            text: 'AutoCAD',
                            style: const TextStyle(
                                color: Color.fromRGBO(255, 116, 87, 1),
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 290,
                    child: const CourseList(
                      isLargeTiled: false,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 20),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(text: 'Top courses in '),
                          TextSpan(
                            text: 'Civil 3D',
                            style: const TextStyle(
                                color: Color.fromRGBO(255, 116, 87, 1),
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 290,
                    child: const CourseList(
                      isLargeTiled: false,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 20),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(text: 'Top courses in '),
                          TextSpan(
                            text: 'Solidworks',
                            style: const TextStyle(
                                color: Color.fromRGBO(255, 116, 87, 1),
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 290,
                    child: const CourseList(
                      isLargeTiled: true,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 20),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(text: 'Top courses in '),
                          TextSpan(
                            text: 'Revit',
                            style: const TextStyle(
                                color: Color.fromRGBO(255, 116, 87, 1),
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 290,
                    child: const CourseList(
                      isLargeTiled: true,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 20),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(text: 'Top courses in '),
                          TextSpan(
                            text: 'Fusion 360',
                            style: const TextStyle(
                                color: Color.fromRGBO(255, 116, 87, 1),
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 290,
                    child: const CourseList(
                      isLargeTiled: true,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 20),
                    child: Text(
                      'Students are viewing',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 290,
                    child: const CourseList(
                      isLargeTiled: false,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 20),
                    child: Text(
                      'Free courses for you',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 290,
                    child: const CourseList(
                      isLargeTiled: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class CustomCourseRow extends StatelessWidget {
  CustomCourseRow({
    Key? key,
  }) : super(key: key);
  final CoursesPicController coursesController =
      Get.put(CoursesPicController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width),
          height: 530,
          color: Colors.white,
          child: Obx(() {
            if (coursesController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              // scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              itemCount: coursesController.courses.length,
              itemBuilder: (context, index) {
                var course = coursesController.courses[index];
                return CourseItem(
                  courseName: course['course_name'],
                  courseIcon: course['course_icon'],
                  onTap: () {
                    // Navigate to CourseDetailScreen on tap
                    Get.to(() => CourseListScreen(
                        courseId: course['course_id'],
                        courseName: course['course_name']));
                  },
                );
              },
            );
          }),
        ),
      ],
    );
  }
}

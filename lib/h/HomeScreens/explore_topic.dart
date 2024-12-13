// explore_topics_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sourcecad_app/h/HomeScreens/course_detail_screen_pic.dart';
import 'package:sourcecad_app/h/controllers/course_pic_controller.dart';
import 'package:sourcecad_app/widgets/course_item_pic.dart';

class ExploreTopicssScreen extends StatelessWidget {
  final CoursesPicController coursesController =
      Get.put(CoursesPicController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Explore Topics.",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (coursesController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: coursesController.courses.length,
                itemBuilder: (context, index) {
                  var course = coursesController.courses[index];
                  return CourseItem(
                    courseName: course['course_name'],
                    courseIcon: course['course_icon'],
                    onTap: () {
                      // Navigate to CourseDetailScreen on tap
                      Get.to(() =>
                          CourseDetailScreen(courseId: course['course_id']));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

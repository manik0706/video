import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sourcecad_app/h/controllers/coursecontroller.dart';
import 'package:sourcecad_app/widgets/course_listwid.dart';

class CourseListScreen extends StatelessWidget {
  final int courseId;
  final String courseName;
  final CourseController courseController = Get.put(CourseController());

  CourseListScreen({required this.courseId, required this.courseName});

  @override
  Widget build(BuildContext context) {
    courseController.fetchCourses(courseId);

    return Scaffold(
      appBar: AppBar(
        title: Text('$courseName Courses'),
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          // Shimmer effect for loading state
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.5,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: 5, // Display a fixed number of shimmer items
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 16,
                                width: 150,
                                color: Colors.grey[300],
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 14,
                                width: 100,
                                color: Colors.grey[300],
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 14,
                                    width: 60,
                                    color: Colors.grey[300],
                                  ),
                                  Container(
                                    height: 14,
                                    width: 60,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (courseController.courses.isEmpty) {
          return Center(child: Text('No courses available'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.5,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: courseController.courses.length,
              itemBuilder: (context, index) {
                return CourseCard(course: courseController.courses[index]);
              },
            ),
          );
        }
      }),
    );
  }
}

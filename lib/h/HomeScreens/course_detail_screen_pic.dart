// course_detail_screen.dart
import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseId;

  CourseDetailScreen({required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseId),
      ),
      body: Center(
        child: Text(
          "Details for $courseId",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

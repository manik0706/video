// course_item.dart
import 'package:flutter/material.dart';

class CourseItem extends StatelessWidget {
  final String courseName;
  final String courseIcon;
  final VoidCallback onTap;

  CourseItem({
    required this.courseName,
    required this.courseIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https:' + courseIcon; // Prepend 'https:' to the icon URL

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.network(
            imageUrl,
            height: 60,
            width: 60,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.broken_image, size: 60),
          ),
          SizedBox(height: 8),
          Text(
            courseName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
